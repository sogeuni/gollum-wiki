Gollum::Page.send :remove_const, :FORMAT_NAMES if defined? Gollum::Page::FORMAT_NAMES

## Omni Auth
require 'omnigollum'
#require 'omniauth/strategies/github'
require 'omniauth/strategies/google_oauth2'

wiki_options = {
  :live_preview => false,
  :allow_uploads => true,
  :per_page_uploads => true,
  :allow_editing => true,
  :css => true,
  :js => true,
  :mathjax => true,
  :h1_title => true
}
Precious::App.set(:wiki_options, wiki_options)

options = {
  # OmniAuth::Builder block is passed as a proc
  :providers => Proc.new do
    # Found https://github.com/settings/applications/
    #provider :github, '3a14a8ba5110df039074', 'ab33265e5ce2ecb4ffdc9183d1e71b961a9c5cf1'
    provider :google_oauth2, '168349078301-7u849d4hk5j4u5a1r7sgspo33cqcia47.apps.googleusercontent.com', 'gnuAAUBbnAoYiCaKy9EKne-z', {
      :scope => 'email,profile',
      :access_type => 'online'
    }
  end,
  :dummy_auth => false,
  # If you want to make pages private:
  #:protected_routes => ['/private*'],

  # Specify committer name as just the user name
  :author_format => Proc.new { |user| user.name },
  # Specify committer e-mail as just the user e-mail
  :author_email => Proc.new { |user| user.email },

  # Authorized users
  :authorized_users => ["sogeuni@gmail.com"],
}


## :omnigollum options *must* be set before the Omnigollum extension is registered
Precious::App.set(:omnigollum, options)
Precious::App.register Omnigollum::Sinatra
