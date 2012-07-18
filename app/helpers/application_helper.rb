module ApplicationHelper

  def git_revision
    `git rev-list --abbrev-commit HEAD | wc -l | awk '{print $1}'`
  end

  def git_id
    repo = Grit::Repo.new(Rails.root)
    last_commit = repo.commits.first
    return last_commit.id
  end

  def git_message
    repo = Grit::Repo.new(Rails.root)
    last_commit = repo.commits.first
    return last_commit.message
  end

  def git_author
    repo = Grit::Repo.new(Rails.root)
    last_commit = repo.commits.first
    return last_commit.author
  end

  def git_timestamp
    repo = Grit::Repo.new(Rails.root)
    last_commit = repo.commits.first
    return last_commit.authored_date
  end

  def server_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily
    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  def server_name
    `hostname`
  end

end
