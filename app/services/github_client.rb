# Github service wrapper
# Retrieves the repositories of a user and identifies the most commonly used language
class GithubClient
  # Custom error for user not found
  class UserNotFound < StandardError
    def message
      'User not found'
    end
  end

  # Custom error for a user without any repositories
  class NoUserRepositories < StandardError
    def message
      'The user has no repositories so no favourite language can be identified'
    end
  end

  # Custom error for a user without any repository languages
  class NoLanguagesUsed < StandardError
    def message
      'The user has not used any programming languages'
    end
  end

  def initialize(username)
    @username = username
  end
  attr_reader :username

  def favourite_language
    languages.max_by { |(_, value)| value }.first
  end

  private

  def client
    @client ||= Octokit::Client.new
  end

  # Calculates the amount of times a language is the prevalent one in the user's repositories
  def languages
    languages = user_repositories.inject(Hash.new(0)) do |data, repo|
      next data if repo.language.nil?

      data.update(repo.language => data[repo.language] + 1)
    end
    languages.empty? ? raise(NoLanguagesUsed) : languages
  end

  def user_repositories
    user_repositories = client.user(username).rels[:repos].get.data
    raise NoUserRepositories if user_repositories.empty?

    user_repositories
  rescue Octokit::NotFound
    raise UserNotFound
  end
end
