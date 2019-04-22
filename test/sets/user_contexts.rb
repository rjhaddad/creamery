module Contexts
  module UserContexts
    # Context for users; assumes initial context for employees already set 
    def create_users
      @reem_user = FactoryBot.create(:user, employee: @reem, email: "reem@example.com")
      @ghada_user = FactoryBot.create(:user, employee: @ghada, email: "ghada@example.com")
      @sultan_user = FactoryBot.create(:user, employee: @sultan, email: "sultan@example.com")
      @alex_user = FactoryBot.create(:user, employee: @alex, email: "alex@example.com")
    end
    
    def destroy_users
      @reem_user.delete
      @ghada_user.delete
      @sultan_user.delete
      @alex_user.delete
    end

  end
end