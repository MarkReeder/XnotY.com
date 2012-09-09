object @event

attributes :_id, :title, :description, :location
node(:is_attending) {|event| event.is_user_attending?(current_user) }
node(:is_organizer) {|event| event.is_organizer?(current_user) }
child :suggestions
node :attendees do |event|
  event.attendees.reject{|u| u.facebook_id.nil?}.map{|u| {:name => u.easy_name, :facebook_id => u.facebook_id}} 
end
node(:organizer) {|event| {:name => event.user.easy_name, :facebook_id => event.user.facebook_id}}

