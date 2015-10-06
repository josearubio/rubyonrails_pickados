class BugtrackingController < ApplicationController
  def new
    @bug = Bugtracker.new
  end


  def create
    #render plain: params[:pick].inspect
    @bug = Bugtracker.new(bug_params)
    #@pick = Pick.new(pick_params)


        if @bug.save
          flash[:success] = "Error reportado correctamente. En breves nuestro equipo se ocupará de él."
          redirect_to bugtracking_index_path
        else
          flash[:danger] = "Error al reportar el bug."
          render 'new'
        end


  end

  def addcomment
    @bug = Bugtracker.find(params[:bug_id])
    @comment = @bug.comments.build(comment_params)
    #@pick = Pick.new(pick_params)


        if @comment.save
          flash[:success] = "Comentario añadido correctamente!"
          redirect_to bugtracking_index_path
        else
          flash[:danger] = "Error al añadir comentario!"
          render bugtracking_index_path
        end

  end

  def index

    @bugs = Bugtracker.paginate(page: params[:page], :per_page => 5)
    @comment = Comment.new
  end

  private
  def bug_params
    params.require(:bugtracker).permit(:usuario, :gravedad, :titulo, :explicacion, :categoria)

  end

  def comment_params
    params.require(:comment).permit(:usuario, :comentario)

  end

end
