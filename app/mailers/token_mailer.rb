#class TokenMailer < Merb::MailController
#
#  # HACK since _mailer_klass doesn't seem to be set correctly in merb-mailer 0.9.3
#  def initialize(*params)
#    self._mailer_klass  = Merb::Mailer
#    super
#  end
#
#  def notify
#    @entry = params[:entry]
#    render_mail
#  end
#
#end

