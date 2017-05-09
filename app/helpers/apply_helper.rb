module ApplyHelper
  def apply_row(param, mandatory, type, label, placeholder, icon)
    {
      placeholder: placeholder,
      mandatory: mandatory,
      type: type,
      label: label,
      param: param.to_s,
      error: @application.errors.messages[param].try(:join, ', '),
      value: @application.send(param),
      icon: icon.starts_with?("fa") ? "fa #{icon}" : "mdi mdi-#{icon}"
    }
  end

  def apply_rows
    [
      apply_row(:first_name, true, :text, t("applies.new.first_name"), "Alan", "account"),
      apply_row(:last_name, true, :text, t("applies.new.last_name"), "Turing", "format-text"),
      apply_row(:age, true, :text, t("applies.new.age"), "42", "crown"),
      apply_row(:email, true, :email, "Email", "alan@turing.com", "email-open"),
      apply_row(:phone, true, :tel, t("applies.new.phone"), "+33612345678", "cellphone-iphone"),
      apply_row(:source, true, :text, t("applies.new.source"), t("applies.new.source_placeholder"), "tag"),
      apply_row(:linkedin, false, :text, t("applies.new.linkedin_html"), t("applies.new.linkedin_placeholder"), "fa-linkedin"),
      apply_row(:codecademy_username, false, :text, t("applies.new.codecademy_username_html"), t("applies.new.codecademy_username_placeholder"), "fa-code"),
      apply_row(:motivation, true, :textarea, t("applies.new.motivation"), t("applies.new.motivation_placeholder"), "content-paste")
    ]
  end
end
