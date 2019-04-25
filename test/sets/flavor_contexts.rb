module Contexts
  module FlavorContexts
    # Context for flavors 
    def create_flavors
      @chocolate  = FactoryBot.create(:flavor)
      @vanilla    = FactoryBot.create(:flavor, name: "Vanilla", active: false)
      @strawberry = FactoryBot.create(:flavor, name: "Strawberry")
      @mint_chip  = FactoryBot.create(:flavor, name: "Mint Chocolate Chip")
    end
    
    def remove_flavors
      @chocolate.destroy
      @vanilla.destroy
      @strawberry.destroy
      @mint_chip.destroy
    end
  end
end