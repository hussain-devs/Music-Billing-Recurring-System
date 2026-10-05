module CrudResponseHandling
  extend ActiveSupport::Concern

  private

  def handle_crud_result(record, success_path:, success_message:)
    if yield
      redirect_to success_path, notice: success_message
    else
      redirect_to success_path,
                  alert: record.errors.full_messages.to_sentence
    end
  end
end
