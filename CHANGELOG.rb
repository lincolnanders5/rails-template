# diff --git a/Gemfile b/Gemfile
# --- a/Gemfile
# +++ b/Gemfile

gem 'devise', '~> 4.7'
gem 'devise-pwned_password', '~> 0.1.4'


# diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
# --- a/app/controllers/application_controller.rb
# +++ b/app/controllers/application_controller.rb

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    # Warn existing users when they sign in if they are using a password from
    # the PwnedPasswords dataset.
    set_flash_message! :alert, :warn_pwned if resource.respond_to?(:pwned?) && resource.pwned?

    request.env['omniauth.origin'] || stored_location_for(resource) || root_url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation)
    end
  end


# diff --git a/app/models/user.rb b/app/models/user.rb
# +++ b/app/models/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :pwned_password
end


# diff --git a/app/views/devise/registrations/new.html.erb b/app/views/devise/registrations/new.html.erb
# +++ b/app/views/devise/registrations/new.html.erb

<h2>Sign Up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :username %><br />
    <%= f.text_field :username %>
  </div>

  <div class="field">
    <%= f.label :password %>
    <% if @minimum_password_length %>
    <em>(<%= @minimum_password_length %> characters minimum)</em>
    <% end %><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>


# diff --git a/app/views/devise/sessions/new.html.erb b/app/views/devise/sessions/new.html.erb
# +++ b/app/views/devise/sessions/new.html.erb

<h2>Log In</h2>

<%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
  <div class="field">
    <%= f.label :username %><br />
    <%= f.text_field :username, autofocus: true, autocomplete: "username" %>
  </div>

  <div class="field">
    <%= f.label :password %><br />
    <%= f.password_field :password, autocomplete: "current-password" %>
  </div>

  <% if devise_mapping.rememberable? %>
    <div class="field">
      <%= f.check_box :remember_me %>
      <%= f.label :remember_me %>
    </div>
  <% end %>

  <div class="actions">
    <%= f.submit "Log in" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>


# diff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb
# +++ b/app/views/layouts/application.html.erb

    <%  %>
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>


# diff --git a/app/views/public/index.html.erb b/app/views/public/index.html.erb
# +++ b/app/views/public/index.html.erb

<h1>Home</h1>
<ul>
  <% if user_signed_in? %>
    <%= link_to "Log Out", destroy_user_session_path %>
  <% else %>
    <li><a href="/users/sign_in">Log In</a></li>
    <li><a href="/users/sign_up">Create Account</a></li>
  <% end %>
</ul>


# diff --git a/config/application.rb b/config/application.rb
# --- a/config/application.rb
# +++ b/config/application.rb

require "action_mailer/railtie"


# diff --git a/config/environments/development.rb b/config/environments/development.rb
# --- a/config/environments/development.rb
# +++ b/config/environments/development.rb

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }


# diff --git a/config/initializers/devise.rb b/config/initializers/devise.rb
# +++ b/config/initializers/devise.rb

  config.mailer_sender = 'no-reply@example.com'.
  require 'devise/orm/active_record'

  config.authentication_keys = [:username]
  config.case_insensitive_keys = %i[email username]
  config.strip_whitespace_keys = %i[email username]

  config.send_email_changed_notification = true
  config.send_password_change_notification = true

  config.confirm_within = 3.days
  config.reconfirmable = true
  config.confirmation_keys = [:email]

  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 16..128
  config.email_regexp = /\A[^@\s]{2,}@[^@\s]{2,}\.[^@\s]{2,}\z/

  config.lock_strategy = :failed_attempts
  config.unlock_keys = [:email]
  config.unlock_strategy = :both
  config.maximum_attempts = 5
  config.unlock_in = 12.hours
  config.last_attempt_warning = false

  config.reset_password_keys = [:email]
  config.reset_password_within = 6.hours
  config.sign_in_after_reset_password = true

  config.scoped_views = true
  config.default_scope = :user

  config.sign_out_via = :get

  config.sign_in_after_change_password = true

  config.min_password_matches = 5
end


# diff --git a/config/routes.rb b/config/routes.rb
# --- a/config/routes.rb
# +++ b/config/routes.rb

  get 'public/index'
  devise_for :users
  root to: "public#index"


# diff --git a/db/migrate/20201217040458_devise_create_users.rb b/db/migrate/20201217040458_devise_create_users.rb
# +++ b/db/migrate/20201217040458_devise_create_users.rb

# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      # Email for account security and username for login
      t.string :email,              null: false, default: ''
      t.string :username,           null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      # Optional given (first) and family (last) names
      t.string :given_name
      t.string :family_name

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :username,             unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end


# diff --git a/db/schema.rb b/db/schema.rb
# +++ b/db/schema.rb

# [ generated ]

# diff --git a/app/views/devise/confirmations/new.html.erb b/app/views/devise/confirmations/new.html.erb
# # +++ b/app/views/devise/confirmations/new.html.erb

# [ generated ]


# diff --git a/app/views/devise/mailer/confirmation_instructions.html.erb b/app/views/devise/mailer/confirmation_instructions.html.erb
# # +++ b/app/views/devise/mailer/confirmation_instructions.html.erb

# [ generated ]


# diff --git a/app/views/devise/mailer/email_changed.html.erb b/app/views/devise/mailer/email_changed.html.erb
# # +++ b/app/views/devise/mailer/email_changed.html.erb

# [ generated ]


# diff --git a/app/views/devise/mailer/password_change.html.erb b/app/views/devise/mailer/password_change.html.erb
# # +++ b/app/views/devise/mailer/password_change.html.erb

# [ generated ]


# diff --git a/app/views/devise/mailer/reset_password_instructions.html.erb b/app/views/devise/mailer/reset_password_instructions.html.erb
# # +++ b/app/views/devise/mailer/reset_password_instructions.html.erb

# [ generated ]


# diff --git a/app/views/devise/mailer/unlock_instructions.html.erb b/app/views/devise/mailer/unlock_instructions.html.erb
# # +++ b/app/views/devise/mailer/unlock_instructions.html.erb

# [ generated ]


# diff --git a/app/views/devise/passwords/edit.html.erb b/app/views/devise/passwords/edit.html.erb
# # +++ b/app/views/devise/passwords/edit.html.erb

# [ generated ]


# diff --git a/app/views/devise/passwords/new.html.erb b/app/views/devise/passwords/new.html.erb
# # +++ b/app/views/devise/passwords/new.html.erb

# [ generated ]


# diff --git a/app/views/devise/registrations/edit.html.erb b/app/views/devise/registrations/edit.html.erb
# ++ b/app/views/devise/registrations/edit.html.erb

# [ generated ]


# diff --git a/app/views/devise/shared/_error_messages.html.erb b/app/views/devise/shared/_error_messages.html.erb
# # +++ b/app/views/devise/shared/_error_messages.html.erb

# [ generated ]


# diff --git a/app/views/devise/shared/_links.html.erb b/app/views/devise/shared/_links.html.erb
# # +++ b/app/views/devise/shared/_links.html.erb

# [ generated ]


# diff --git a/app/views/devise/unlocks/new.html.erb b/app/views/devise/unlocks/new.html.erb
# # +++ b/app/views/devise/unlocks/new.html.erb

# [ generated ]


# diff --git a/Gemfile.lock b/Gemfile.lock
# --- a/Gemfile.lock
# +++ b/Gemfile.lock

# [ generated ]


# diff --git a/app/assets/stylesheets/public.css b/app/assets/stylesheets/public.css
# # +++ b/app/assets/stylesheets/public.css

# [ generated ]


# diff --git a/app/controllers/public_controller.rb b/app/controllers/public_controller.rb
# # +++ b/app/controllers/public_controller.rb

# [ generated ]


# diff --git a/app/helpers/public_helper.rb b/app/helpers/public_helper.rb
# # +++ b/app/helpers/public_helper.rb

# [ generated ]