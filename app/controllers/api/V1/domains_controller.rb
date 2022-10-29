module Api
  module V1
    class DomainsController < BaseController
      def index
        @domains = Domain.all.page(page)
      end
    end
  end
end
