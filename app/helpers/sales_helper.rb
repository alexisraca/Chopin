module SalesHelper
  def remote_paginate(collection, options = {})
    will_paginate(
      collection,
      remote_paginate_options(options).
        merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
    )
  end

  private

  def remote_paginate_options(remote_options = {})
    options = {
      params: {
        statement_id: @statement.id
      }
    }.merge(remote_options)
    options[:q] = params[:q] unless params[:q].blank?
    options
  end
end
