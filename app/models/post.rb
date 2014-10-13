class Post < ActiveRecord::Base
  attr_accessible :photo, :titulo
  validates_presence_of :titulo, :extension

  #un post pertenece a un usuario
  belongs_to :user

  after_save :guardar_foto #se ejecuta despues de ciertas acciones en el modelo
                           #se guardan la extension y el titulo de la foto en la bd 
  FOTOS = File.join Rails.root, 'public', 'photo_store'
  #join crea una ruta, root hacer referencia a la carpeta donde se encuentre la app 
  #ex: /rails_code/gag_cf = Rails.root/public/photo_store

  def photo=(file_data)
  	unless file_data.blank?
  		@file_data=file_data
  		self.extension = file_data.original_filename.split('.').last.downcase
      #guarda la extension del archivo
  	end	

  end

  #va a crear el nombre del archivo que se va a crear
  def photo_filename
    File.join FOTOS, "#{id}.#{extension}"
    #ex: /gag_cf/public/photo_store/23.png
    #recordar todos los metodos en ruby retornan la ultima linea por defecto
  end

  def photo_path
    "/photo_store/#{id}.#{extension}"
  end

  #verifica si un archivo existe
  def has_photo?
    File.exists? photo_filename
  end

  private

  def guardar_foto
  	if @file_data
  		FileUtils.mkdir_p FOTOS  #Fileutils permite modificar y manipular archivos
  		File.open(photo_filename, 'wb') do |f|
  			f.write(@file_data.read)
  	    end
  	    @file_data = nil
    end
  end

end
