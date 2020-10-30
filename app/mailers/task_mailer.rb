class TaskMailer < ApplicationMailer
  default from: 'taskleaf@example.com'

  def creation_email(task)
    @task = task
    @user = task.user
    mail(
      subject: 'タスク作成完了メール',
      to: @user.email
    )
  end
end
