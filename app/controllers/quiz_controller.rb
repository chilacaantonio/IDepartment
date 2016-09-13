class QuizController < ApplicationController
  before_action :varios, only: [:c1,:c2,:c3,:rc1,:index,:resultados]
  before_action :q2, only: [:rc2,:rc3,:index,:evalua1,:resultados]
  before_action :authenticate_user!, except: [:index]
  before_action :existe, only: [:index,:preg1,:preg2,:preg3,:preg4,:c1,:c2,:c3,:resultados,:evalua1,:rc1,:rc2,:rc3,:inicio]

  def index
  end

  def inicio
    if @opc
      redirect_to root_path
    end
  end

  def resultados
  end

  def preg1
    if @opc
      redirect_to root_path
    end
  end

  def resp1
    if params[:choice].present?
    choiceid = params[:choice].to_i
    if choiceid<3
      if current_user.grado.to_i > 2 || current_user.grado == nil
        $mivar = 0
      else
          $mivar = 1
      end
      redirect_to quiz_preg2_path
    else
      if current_user.grado.to_i > 2
        $mivar = 0
      else
          $mivar = 2
      end
      redirect_to quiz_preg4_path
    end
  else
    #redirect_to :back,  notice: 'Selecciona una opcion'
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
          redirect_to :back, notice: 'Selecciona una opcion'
        else
          redirect_to root_path
        end


  end

  end

  def preg2
    if @opc
      redirect_to root_path
    end
  end

  def resp2
    if params[:choice].present?
    redirect_to quiz_preg3_path
    else
    redirect_to :back,  notice: 'Selecciona una opcion'
    end
  end

  def preg3
    if @opc
      redirect_to root_path
    end
  end

  def preg4
    if @opc
      redirect_to root_path
    end
  end

  def evalua1
    if !@opc
    if params[:choice].present?
      @opcion = params[:choice].to_i
      if $mivar == 0
        if(@opcion == 1)
          Resp.create(cual: @imagen[12],user_id: current_user.id,res: "2")
        elsif (@opcion == 2)
          Resp.create(cual: @imagen[13],user_id: current_user.id,res: "2")
        else
          Resp.create(cual: @imagen[14],user_id: current_user.id,res: "2")
        end
    elsif $mivar == 1
      @valores = []
      @valores[0]=12
      @valores[1]=15
      @valores.each do |var|
        Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
      end

    elsif $mivar == 2
      @valores = []
      @valores[0]=16
      @valores[1]=17
      @valores.each do |var|
        Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
      end
    end
      redirect_to quiz_resultados_path
    else
      #redirect_to :back,  notice: 'Selecciona una opcion'
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
            redirect_to :back, notice: 'Selecciona una opcion'
          else
            redirect_to root_path
          end
          #

    end

  else
    redirect_to root_path
  end

  end

  def resp4
    if params[:choice].present?
      choiceid = params[:choice].to_i
      if choiceid<3
        redirect_to quiz_c1_path
      else
        if choiceid<5
          redirect_to quiz_c2_path
        else
          redirect_to quiz_c3_path
        end
      end
    else
    redirect_to :back, notice: 'Selecciona una opcion'
    end
  end

  def c1
    if @opc
      redirect_to root_path
    end
  end

  def c2
    if @opc
      redirect_to root_path
    end
  end

  def c3
    if @opc
      redirect_to root_path
    end
  end

  def rc1  #respuestas a
    if !@opc
    if params[:product].present?
      if params[:product][:id].length == 3
        if $mivar == 0
          @varios = params[:product][:id]
          @varios.each do |var|
            Resp.create(cual: @idr[var.to_i],user_id: current_user.id,res: "1")
        end
      elsif $mivar == 1
        @valores = []
        @valores[0]=12
        @valores[1]=15
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end

      elsif $mivar == 2
        @valores = []
        @valores[0]=16
        @valores[1]=17
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end
      end
      redirect_to quiz_resultados_path
      else
        redirect_to :back, notice: 'Selecciona 3 categorias'
      end
    else
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
            redirect_to :back, notice: 'Selecciona 3 categorias'
          else
            redirect_to root_path
          end
    end
  else
    redirect_to root_path
  end
  end

  def rc2  #respuestas b
    if !@opc
    if params[:product].present?
      if params[:product][:id].length == 3
        @valores = []
        @varios = params[:product][:id]
        #["Econ","IR","IS","Soc","Env","IJ","Tec"]
        if $mivar == 0
        if ("Econ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s ) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
          @valores[2]=2
          @valores[3]=3
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=2
          @valores[2]=3
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=0
          @valores[2]=4
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)  ####
          @valores[0]=0
          @valores[1]=5
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=5
          @valores[2]=6
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=4
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=4
          @valores[2]=5
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=5
          @valores[2]=6
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=4
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=2
          @valores[1]=3
          @valores[2]=4
          @valores[3]=5
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=2
          @valores[1]=3
          @valores[2]=5
          @valores[3]=6
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=4
          @valores[2]=5
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=5
          @valores[2]=6
        elsif ("Env" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
          @valores[2]=4
        elsif ("Env" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=4
        elsif ("Env" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=4
          @valores[1]=5
          @valores[2]=6
        elsif ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cualIR[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
          @valores[2]=5
        elsif ("IJ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=5
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
          @valores[2]=6
        elsif ("Tec" == @cual[@varios[0].to_i].to_s  &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=6
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=6
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=4
          @valores[2]=6
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=2
          @valores[2]=3
          @valores[3]=4
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
          @valores[2]=5
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=4
          @valores[2]=6
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=4
          @valores[2]=6
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
####SIN VALOR
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=4
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=5
        elsif ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=2
          @valores[2]=3
          @valores[3]=5
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=6
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=2
          @valores[2]=3
          @valores[3]=6
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=0
          @valores[1]=1
          @valores[2]=6
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=1
          @valores[1]=2
          @valores[2]=3
          @valores[3]=5
        #
        else

        end
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end
      elsif $mivar == 1
        @valores[0]=12
        @valores[1]=15
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end

      elsif $mivar == 2
        @valores[0]=16
        @valores[1]=17
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end
      end
        redirect_to quiz_resultados_path
        #
      else
        redirect_to :back, notice: 'Selecciona 3 categorias'
      end
    else
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
            redirect_to :back, notice: 'Selecciona 3 categorias'
          else
            redirect_to root_path
          end
    end
  else
    redirect_to root_path
  end
  end

  def rc3  #respuestas c
  if !@opc
    if params[:product].present?
      if params[:product][:id].length == 3
        @valores = []
        @varios = params[:product][:id]
        if $mivar == 0
        #["Econ","IR","IS","Soc","Env","IJ","Tec"]
        if ("Econ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s ) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=7
          @valores[3]=8
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=7
          @valores[2]=8
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=9
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)  ####
          @valores[0]=5
          @valores[1]=9
          @valores[2]=10
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=10
          @valores[3]=11
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=6
          @valores[3]=8
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=9
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=9
          @valores[2]=10
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=6
          @valores[2]=10
          @valores[3]=11
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=7
          @valores[2]=8
          @valores[3]=9
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=7
          @valores[1]=8
          @valores[2]=9
          @valores[3]=10
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=6
          @valores[1]=7
          @valores[2]=8
          @valores[3]=10
          @valores[4]=11
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=9
          @valores[2]=10
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=10
          @valores[3]=11
        elsif ("Env" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=9
        elsif ("Env" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=7
          @valores[2]=8
          @valores[3]=9
        elsif ("Env" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Env" == @cual[@varios[2].to_i].to_s &&  "IJ" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[1].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Env" == @cual[@varios[0].to_i].to_s &&  "IJ" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=6
          @valores[1]=9
          @valores[2]=10
          @valores[3]=11
        elsif ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cualIR[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=10
        elsif ("IJ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=8
          @valores[2]=10
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=6
          @valores[3]=11
        elsif ("Tec" == @cual[@varios[0].to_i].to_s  &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=6
          @valores[2]=8
          @valores[3]=11
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Soc" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Soc" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=8
          @valores[3]=11
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=9
          @valores[3]=11
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Env" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Env" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=8
          @valores[2]=9
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=10
        elsif ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("Econ" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("Econ" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=9
          @valores[3]=11
        elsif ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IR" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IR" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=6
          @valores[2]=9
          @valores[3]=11
        elsif ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[0].to_i].to_s && "Tec" == @cual[@varios[2].to_i].to_s) ||
          ("IS" == @cual[@varios[2].to_i].to_s &&  "Env" == @cual[@varios[1].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[1].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[0].to_i].to_s) ||
          ("IS" == @cual[@varios[0].to_i].to_s &&  "Env" == @cual[@varios[2].to_i].to_s && "Tec" == @cual[@varios[1].to_i].to_s)
          @valores[0]=6
          @valores[1]=8
          @valores[2]=9
          @valores[3]=11
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IR" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "IR" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=10
        elsif ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[0].to_i].to_s && "IS" == @cual[@varios[2].to_i].to_s) ||
          ("IJ" == @cual[@varios[2].to_i].to_s &&  "Econ" == @cual[@varios[1].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[1].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[0].to_i].to_s) ||
          ("IJ" == @cual[@varios[0].to_i].to_s &&  "Econ" == @cual[@varios[2].to_i].to_s && "IS" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=8
          @valores[2]=10
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "IR" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "IR" == @cual[@varios[1].to_i].to_s)
          @valores[0]=3
          @valores[1]=5
          @valores[2]=6
          @valores[3]=11
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=8
          @valores[3]=11
        elsif ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[0].to_i].to_s && "Econ" == @cual[@varios[2].to_i].to_s) ||
          ("Tec" == @cual[@varios[2].to_i].to_s &&  "Soc" == @cual[@varios[1].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[1].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[0].to_i].to_s) ||
          ("Tec" == @cual[@varios[0].to_i].to_s &&  "Soc" == @cual[@varios[2].to_i].to_s && "Econ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=5
          @valores[1]=6
          @valores[2]=11
        elsif ("Soc" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[0].to_i].to_s && "IJ" == @cual[@varios[2].to_i].to_s) ||
          ("Soc" == @cual[@varios[2].to_i].to_s &&  "IS" == @cual[@varios[1].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[1].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[0].to_i].to_s) ||
          ("Soc" == @cual[@varios[0].to_i].to_s &&  "IS" == @cual[@varios[2].to_i].to_s && "IJ" == @cual[@varios[1].to_i].to_s)
          @valores[0]=7
          @valores[1]=8
          @valores[2]=10
        #
        else

        end
        ##
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end
      elsif $mivar == 1
        @valores[0]=12
        @valores[1]=15
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end

      elsif $mivar == 2
        @valores[0]=16
        @valores[1]=17
        @valores.each do |var|
          Resp.create(cual: @imagen[var.to_i],user_id: current_user.id,res: "2")
        end
      end
        redirect_to quiz_resultados_path
        #
      else
        redirect_to :back, notice: 'Selecciona 3 categorias'
      end
    else
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
            redirect_to :back, notice: 'Selecciona 3 categorias'
          else
            redirect_to root_path
          end
          #
    end
  else
    redirect_to root_path
  end
  end

  private

  def varios
    @respuestas = ["Economy","International Relationships","International Security","Society","Enviroment/Health","International Justice","Technology"]
    @idr = ["ilo","who","sc","uni","fao","icc","cst"]
    @titulo1 = ["International Labor Organization (ILO)",
    "World Health Organization (WHO)","Security Council (SC)",
    "United Nations International Children´s Emergency Fund (UNICEF)",
  "Food and Agriculture Organization of the United Nations (FAO)",
"International Criminal Court (ICC)","Commission on Science and Technology for Development (CSTD)"]
    @sub1 = ["Unemployment Caused by Artificial Intelligence",
    "Prevention of Mosquitoe Proliferation to Fight Mosquitoe-Born Diseases","Kurdish Conflict",
  "Education for Children with Disabilities","Administration of Alimentary Resources",
"Against Lyndon B. Johnson for the Acts of Wars Committed in The Operation Ranch Hand",
"Superbug Relentless Threat"]
    @quien1 = ["Daniel Contreras, Alan Aguilar, Pablo Alduncin",
      "Monserrat Barrientos, Jorge Tenorio, Melanie León","Paola Solís, José Diego Romero, Jesús Daniel",
    "Daniela Villa Lombardero, José Bulnes Martínez, Regina Peredo","María José Alejo Flores, Valeria Lorena Cano Echeverría",
  "","María José Campos, Amanda Polcaqui, Miguel Jiménez "]

    @level1 = ["Standard","Standard","Standard","Introductory","Introductory","Standard","Standard"]
    @grade1 = ["High School","High School","High School","Middle High School","Middle High School","High School","High School"]
    @url1 = ["https://damunapp.wordpress.com/2016/06/07/international-labour-organization-ilo/",
      "https://damunapp.wordpress.com/2016/06/07/economic-and-social-council-ecosoc/","https://damunapp.wordpress.com/2016/06/07/","https://damunapp.wordpress.com/2016/06/07/united-nations-international-childrens-emergency-fund-unicef/",
      "https://damunapp.wordpress.com/2016/06/07/world-health-organization-who/",
      "https://damunapp.wordpress.com/2016/06/07/international-court-of-justice-icj/",
      "https://damunapp.wordpress.com/2016/06/07/commission-on-science-and-technology-for-development-cstd/"
    ]
  end

  def q2
    @cual = ["Econ","IR","IS","Soc","Env","IJ","Tec"]
    @imagen = ["ilo","ga","hsc","sc","unep","ecosoc","unodc","crisis","esc","who","icc","cstd","cct","cpi","glam","fao","uni","hrc"]
    @titulo = ["International Labour Organization (ILO)","General Assembly (GA)","Historical Security Council (HSC)","Security Council (SC)","United Nations Environment Programme (UNEP)",
    "Economic and Social Council (ECOSOC)","United Nations Office on Drugs and Crime (UNODC)","CRISIS","Emergency Security Council (ESC)","World Health Organization (WHO)","International Criminal Court (ICC)",
  "Commission on Science and Technology for Development (CSTD)","Comité Contra el Terrorismo (CCT)","Corte Penal Internacional (CPI)","Gabinete Legal y Ampliado Mexicano (GLAM)",
  "Food and Agriculture Organization of the United Nations (FAO)","United Nations International Children’s Emergency Fund (UNICEF)","Human Rights Council (HRC)"]
    @sub = ["Unemployment Caused by Artificial Intelligence","Intervention in Emerging Countries","Third Arab Israeli War","Kurdish Conflict","Air Pollution in Cosmopolitan Cities",
    "Global Refugee Immigration Overload","Cyber Terrorism: Internet as a Tool for Terrorist Attacks","Secret Topic","Secret Topic","Prevention of Mosquitoe Proliferation to Fight Mosquitoe-Born Diseases",
  "Against Lyndon B. Johnson for the Acts of Wars Committed in The Operation Ranch Hand","Superbug Relentless Threat",
  "Régimen Talibán en Afganistán","Corte Penal Internacional (CPI)","Llegada de Petróleo Extranjero a México","Administration of Alimentary Resources","Education for Children with Disabilities","Human Trafficking for forced labor
  purposes"]
    @quien = ["Daniel Contreras, Alan Aguilar, Pablo Alduncin","Silvana Inés Rodal Fregoso, Victoria María Ostrowski López","Francisco Morales, Emiliano Quiñonez","Paola Solís, José Diego Romero, Jesús Daniel",
    "Vicente Tolama Paisano, Juan Pablo Castillo Mendoza, Sofía Ramírez Gross","Ana Paola Prado, Metzery Celaya, Markova Lozano","Ana Elisa López, Mauricio Tenorio, Javier Rischtl",
  "Andrés Lappe, Daniela Rojo","Camila Valdivieso, Andrea Rossano, Ana Paola Roanova","Monserrat Barrientos, Jorge Tenorio, Melanie León","Julio Morales, Maximiliano Lopezlarssen, Jessica Adame",
  "María José Campos, Amanda Polcaqui, Miguel Jiménez","Andrea López, Ian Valdovinos, Arantza Martínez","Roberto André Osornio Villareal, Carlos Rincón Castell, Jorge Augusto Tavera Manzanilla","Ruben Bringas, Luis Enrique de la Concha, Alejandro Vargas",
  "María José Alejo Flores, Valeria Lorena Cano Echeverría","Daniela Villa Lombardero, José Bulnes Martínez, Regina Peredo","Heinz Hermann Wendler Alfaro, Angela Sofia Crocker Sanchez, Alexa Orive
  Coronel"]
    @level = ["Standard","Advanced","Standard","Standard","Standard","Advanced","Standard","Advanced","Advanced","Standard","Standard","Standard","Estandar","Estandar","Estandar","Introductory","Introductory","Standard"]
    @grade = ["High School","High School","High School","High School","High School","High School","High School","High School (No pairs allowed)","High School (No pairs allowed)","High School (No pairs allowed)",
      "High School (No pairs allowed)","High School (No pairs allowed)","Secundaria (No se permiten parejas)","Bachillerato","Bachillerato","Middle School","Middle High School"," Middle School (No pairs allowed)"]
    @url = ["https://damunapp.wordpress.com/2016/06/07/international-labour-organization-ilo/","https://damunapp.wordpress.com/2016/06/12/general-assembly-ga/",
    "https://damunapp.wordpress.com/2016/06/07/historical-security-council-hsc/","https://damunapp.wordpress.com/2016/06/07/","https://damunapp.wordpress.com/2016/06/07/united-nations-environment-programme-unep/",
  "https://damunapp.wordpress.com/2016/06/07/economic-and-social-council-ecosoc/","https://damunapp.wordpress.com/2016/06/07/united-nations-office-on-drugs-and-crime-unodc/","https://damunapp.wordpress.com/2016/06/07/",
  "https://damunapp.wordpress.com/2016/06/07/emergency-security-council-ega/","https://damunapp.wordpress.com/2016/06/07/economic-and-social-council-ecosoc/","https://damunapp.wordpress.com/2016/06/07/international-court-of-justice-icj/",
  "https://damunapp.wordpress.com/2016/06/07/commission-on-science-and-technology-for-development-cstd/","https://damunapp.wordpress.com/2016/06/07/food-and-agriculture-organization-of-the-united-nations-fao/",
  "https://damunapp.wordpress.com/2016/06/07/international-criminal-court-icc/","https://damunapp.wordpress.com/2016/06/07/ctc-2/"]
  end


  def existe
    if Resp.exists?(user_id: current_user)
      @datos=Resp.where(user_id: current_user)
      @donde=@datos.first
      @ss=@donde.res
      @opc = true
    else
      @opc= false
    end
  end

end
