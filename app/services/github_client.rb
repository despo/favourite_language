# Github service wrapper
# Retrieves the repositories of a user and identifies the most commonly used language
class GithubClient
  # Custom error for user not found
  class UserNotFound < StandardError
    def message
      'User not found'
    end
  end

  def initialize(username)
    @username = username
  end
  attr_reader :username

  def favourite_language
    languages = user_repositories.inject(Hash.new(0)) do |data, repo|
      data.update(repo.language => data[repo.language] + 1)
    end
    languages.max_by { |(_, value)| value }.first
  end

  private

  def client
    @client ||= Octokit::Client.new
  end

  def user_repositories
    client.user(username).rels[:repos].get.data
  rescue Octokit::NotFound
    raise UserNotFound
  end
end
