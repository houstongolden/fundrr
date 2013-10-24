class GroupsController < ApplicationController
	def index
		@groups = Group.all
		@group = Group.new
	end

	def show
		@group = Group.find(params[:id])
	end

	def create
		g = Group.create(params[:group].permit(:name, :descrip))
		# Make the currently logged-in user a member of the group
		g.gusers << current_user
		redirect_to action:"index"
	end

	def update
		# This digs through all the groups, and compares each one against
		# all incoming params to see if one is named grp#### where ####
		# matches the ID of the group.  If so, it marks the boolean variable
		# is_member.
		# Then it tests to see if this user is a part of the group, and if
		# they should be it makes it happen, or if they should be removed
		# then it does that also.
		Group.all.each do |g|
			is_member = false	# Start by pessimistically expecting we're not a member
			params.each do |key, value| 
			  if key.index("grp") == 0	# Make sure it's a group checkbox
			   	if g.id.to_s == key[3..key.length-1]	# Test this group's ID against the checkbox name
			   		is_member = true	# Got a match!
			   	end
			  end
			end
			# Do we need to remove them?
		   	if(g.gusers.include?(current_user) && ! is_member)
		   		g.gusers.delete(current_user)
		   	end
		   	# Need to add them?
		   	if(! g.gusers.include?(current_user) && is_member)
		   		g.gusers << current_user
			end
		end
		#Head back into the index view
		redirect_to groups_url
	end

end
