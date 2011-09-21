class Ability
  include CanCan::Ability
  
  def initialize(user)
     user ||= User.new
     
     if user.role == "manager"
       can :manage, Firm
        can :manage, User, :firm => {:id => user.firm_id}
        can :manage, Customer, :firm => {:id => user.firm_id}
        can :manage, Project, :firm => {:id => user.firm_id}
        can :manage, Log, :firm => {:id => user.firm_id}
     else
       if user
        can :read, Firm
        can :manage, User, :firm => {:id => user.firm_id}
        can :read, Customer, :firm => {:id => user.firm_id}
        can :read, Project, :firm => {:id => user.firm_id}
        can :manage, Log, :firm => {:id => user.firm_id}
       end   
     
          
        
     
      
      
     #    if user.manager? 
     #      can :manage, User
     #    else 
               
     #      can :create, Comment
     #      can :update, Comment do |comment|
     #        comment.try(:user) == user
     #      end
     #      if user.role?(:author)
     #        can :create, Article
     #        can :update, Article do |article|
     #        article.try(:user) == user
     #       end
     #    end
     #   end
      
       can :create, Firm
      end
   end
  
 
end
