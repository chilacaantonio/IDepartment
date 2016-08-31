class PrincipalesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :varios, only: [:show]
  before_action :opciones, only: [:index]
  before_action :q2, only: [:show]
  def index
    @search = User.where("name LIKE ?","%#{params[:searchbox]}%").where(admin: nil)
    @per_page = params[:per_page] || 1
    @users = @search.joins('LEFT JOIN resps on resps.user_id = users.id').distinct.paginate(page: params[:page], per_page: @per_page)
    @usuarios = User.joins('LEFT JOIN resps on resps.user_id = users.id').where(admin: nil).distinct
    respond_to do |format|
    format.html
    format.csv #{ send_data @usuarios.to_csv }
    format.xls # { send_data @products.to_csv(col_sep: "\t") }
  end

 end

 def show
   if Resp.exists?(user_id: params[:id])
     @datos=Resp.where(user_id: params[:id])
     @donde=@datos.first
     @ss=@donde.res
     @user= User.find(params[:id])
     @opc = true
   else
     @opc= false
   end
 end


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
   @imagen = ["ilo","ga","hsc","sc","unep","ecosoc","unodc","crisis","esc","who","icc","cstd","cct","cpi","glam"]
   @titulo = ["International Labour Organization (ILO)","General Assembly (GA)","Historical Security Council (HSC)","Security Council (SC)","United Nations Environment Programme (UNEP)",
   "Economic and Social Council (ECOSOC)","United Nations Office on Drugs and Crime (UNODC)","CRISIS","Emergency Security Council (ESC)","World Health Organization (WHO)","International Criminal Court (ICC)",
 "Commission on Science and Technology for Development (CSTD)","Comité Contra el Terrorismo (CCT)","Corte Penal Internacional (CPI)","Gabinete Legal y Ampliado Mexicano (GLAM)"]
   @sub = ["Unemployment Caused by Artificial Intelligence","Intervention in Emerging Countries","Third Arab Israeli War","Kurdish Conflict","Air Pollution in Cosmopolitan Cities",
   "Global Refugee Immigration Overload","Cyber Terrorism: Internet as a Tool for Terrorist Attacks","Secret Topic","Secret Topic","Prevention of Mosquitoe Proliferation to Fight Mosquitoe-Born Diseases",
 "Against Lyndon B. Johnson for the Acts of Wars Committed in The Operation Ranch Hand","Superbug Relentless Threat",
 "Régimen Talibán en Afganistán","Corte Penal Internacional (CPI)","Llegada de Petróleo Extranjero a México"]
   @quien = ["Daniel Contreras, Alan Aguilar, Pablo Alduncin","Silvana Inés Rodal Fregoso, Victoria María Ostrowski López","Francisco Morales, Emiliano Quiñonez","Paola Solís, José Diego Romero, Jesús Daniel",
   "Vicente Tolama Paisano, Juan Pablo Castillo Mendoza, Sofía Ramírez Gross","Ana Paola Prado, Metzery Celaya, Markova Lozano","Ana Elisa López, Mauricio Tenorio, Javier Rischtl",
 "Andrés Lappe, Daniela Rojo","Camila Valdivieso, Andrea Rossano, Ana Paola Roanova","Monserrat Barrientos, Jorge Tenorio, Melanie León","Julio Morales, Maximiliano Lopezlarssen, Jessica Adame",
 "María José Campos, Amanda Polcaqui, Miguel Jiménez","-","Roberto André Osornio Villareal, Carlos Rincón Castell, Jorge Augusto Tavera Manzanilla","Ruben Bringas, Luis Enrique de la Concha, Alejandro Vargas"]
   @level = ["Standard","Advanced","Standard","Standard","Standard","Advanced","Standard","Advanced","Advanced","Standard","Standard","Standard","Estandar","Estandar","Estandar"]
   @grade = ["High School","High School","High School","High School","High School","High School","High School","High School (No pairs allowed)","High School (No pairs allowed)","High School (No pairs allowed)",
     "High School (No pairs allowed)","High School (No pairs allowed)","Secundaria","Bachillerato","Bachillerato"]
   @url = ["https://damunapp.wordpress.com/2016/06/07/international-labour-organization-ilo/","https://damunapp.wordpress.com/2016/06/12/general-assembly-ga/",
   "https://damunapp.wordpress.com/2016/06/07/historical-security-council-hsc/","https://damunapp.wordpress.com/2016/06/07/","https://damunapp.wordpress.com/2016/06/07/united-nations-environment-programme-unep/",
 "https://damunapp.wordpress.com/2016/06/07/economic-and-social-council-ecosoc/","https://damunapp.wordpress.com/2016/06/07/united-nations-office-on-drugs-and-crime-unodc/","https://damunapp.wordpress.com/2016/06/07/",
 "https://damunapp.wordpress.com/2016/06/07/emergency-security-council-ega/","https://damunapp.wordpress.com/2016/06/07/economic-and-social-council-ecosoc/","https://damunapp.wordpress.com/2016/06/07/international-court-of-justice-icj/",
 "https://damunapp.wordpress.com/2016/06/07/commission-on-science-and-technology-for-development-cstd/","https://damunapp.wordpress.com/2016/06/07/food-and-agriculture-organization-of-the-united-nations-fao/",
 "https://damunapp.wordpress.com/2016/06/07/international-criminal-court-icc/","https://damunapp.wordpress.com/2016/06/07/ctc-2/"]
 end

 def opciones
   @indice=[['1',1],['2',2],['3',3]]
 end

end
