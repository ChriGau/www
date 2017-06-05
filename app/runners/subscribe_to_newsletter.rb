require "gibbon"

class SubscribeToNewsletter
  def initialize(email, options = {})
    @gibbon = Gibbon::Request.new(api_key: options.fetch(:api_key, ENV['MAILCHIMP_API_KEY']))
    @list_id = options.fetch(:list_id, ENV['MAILCHIMP_LIST_ID'])
    @email = email
    @from_path = options[:from_path]
    @free_track = options[:free_track]
    @city = options[:city]
  end

  def run
    begin
      @gibbon.lists(@list_id).members.create(
        body: {
          email_address: @email,
          status: "subscribed",
          merge_fields: {
            FROM_PATH: @from_path,
            FREE_TRACK: @free_track,
            CITY: @city
          }
        }
      )
      return { ok: true, already_subscribed: false }
    rescue Gibbon::MailChimpError => e
      if e.body && e.body["detail"] =~ /is already a list member/
        return { ok: true, already_subscribed: true }
      else
        if e.body
          return { ok: false, message: e.body["detail"], errors: e.body['errors'] }
        else
          return { ok: false }
        end
      end
    end
  end
end
