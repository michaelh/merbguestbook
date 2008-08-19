module Admin
  class Entries < Application
    
    def index
      @entries = Entry.paginate_admin_recent_entries(:page => params[:page], :per_page => Entry::PAGINATION_PER_PAGE)
      render
    end
    
    def delete
      Entry.destroy(params[:id])
      redirect url(:action => "index")
    rescue ActiveRecord::RecordNotFound
      raise NotFound
    end
    
    def toggle_show
      @entry = Entry.find(params[:id])
      @entry.show = !@entry.show
      @entry.save
      redirect url(:action => "index")
    rescue ActiveRecord::RecordNotFound
      raise NotFound
    end
    
    def edit
      @entry = Entry.find(params[:id])
      @entry.attributes = params[:entry] if params[:entry]
      
      if @entry.valid? && params[:post_button]
        @entry.save
        redirect url(:action => "index")
      else
        render
      end
    rescue ActiveRecord::RecordNotFound
      raise NotFound
    end
    
  end
end
