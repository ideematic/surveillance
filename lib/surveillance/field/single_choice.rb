module Surveillance
  module Field
    class SingleChoice < Base
      include OtherChoice
      setting :randomize, type: :boolean, default: false

      def choosable?
        true
      end

      def view_name
        "choice"
      end

      def answer_string
        other_choosed? ? super : answer.options.map(&:title).join("|")
      end

      def validate_answer answer
        self.answer = answer

        if question.mandatory && empty?
          answer.errors[:option] << I18n.t("errors.messages.empty")
        end

        if other_choosed? && !answer.content
          answer.errors[:content] << I18n.t("errors.messages.empty")
        end
      end

      def ordered_options
        if setting_value(:randomize) == "1"
          question.options.sort_by { rand }
        else
          question.options
        end
      end
    end
  end
end
