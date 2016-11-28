# IconTextFieldInput prefixes a supplied icon before the text field
class IconTextFieldInput < SimpleForm::Inputs::Base
  include SimpleForm::Helpers::Iconify

  # Generates the HTML output for the input
  #
  # @param wrapper_options [Hash] options for the wrapper
  # @return [String] HTML markup of the input
  def input(wrapper_options)
    iconify do
      "#{@builder.text_field(attribute_name, merged_input_options)}".html_safe
    end
  end
end
