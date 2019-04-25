module Contexts
  module StoreFlavorContexts
    # Context for flavors 
    def create_store_flavors
      @chocolate_cmu      = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @cmu)
      @chocolate_oakland  = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @oakland)
      @strawberry_cmu     = FactoryBot.create(:store_flavor, flavor: @strawberry, store: @cmu)
      @strawberry_oakland = FactoryBot.create(:store_flavor, flavor: @strawberry, store: @oakland)
      @mint_chip_cmu      = FactoryBot.create(:store_flavor, flavor: @mint_chip, store: @cmu)
    end
    
    def remove_store_flavors
      @chocolate_cmu.destroy
      @chocolate_oakland.destroy
      @strawberry_cmu.destroy
      @strawberry_oakland.destroy
      @mint_chip_cmu.destroy
    end
  end
end