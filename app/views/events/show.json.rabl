object @event

attributes :_id, :title, :description
node(:is_attending) { @event.is_user_attending?(current_user) }
child @event.suggestions => :suggestions
child @event.invites.map(&:invited_user).reject{|u| u.facebook_id.nil?}.map{|u| {:name => u.easy_name, :facebook_id => u.facebook_id}} => :attendees
node(:organizer) { {:name => @event.user.easy_name, :facebook_id => @event.user.facebook_id}}

