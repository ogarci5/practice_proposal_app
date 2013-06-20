module ProposalsHelper
  def email_proposer(email, proposal)
    Resque.enqueue(MailGun, email, proposal)
  end
end
