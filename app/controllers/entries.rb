class Entries < Application
  
  def index
    @entry = Entry.new
    @entries = Entry.paginate_recent_entries(:page => params[:page], :per_page => Entry::PAGINATION_PER_PAGE)
    render
  end
  
  def create
    @entry = Entry.new(params[:entry])
    @entry.created_at = Time.now

    if @entry.valid? && params[:post_button]
      begin
        if verify_recaptcha
          @entry.show = true
          @entry.save
          redirect url(:action => "index")
        else
          #STDOUT.puts "Recaptcha validation failed"
          render
        end
      rescue
        #STDOUT.puts "Failure during recaptcha validation"
      end
    else
      render
    end
  end
  
end
