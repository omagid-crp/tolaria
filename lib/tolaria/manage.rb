module Tolaria

  @managed_classes = []
  @managed_controllers = []

  def self.managed_classes
    @managed_classes
  end

  def self.managed_controllers
    @managed_controllers
  end

  def self.manage(klass, options = {}, &block)
    discard_managed_class(klass)
    managed_klass = Tolaria::ManagedClass.create(klass, options)
    managed_controller = Class.new(Tolaria::ResourceController)
    ::Admin.const_set(managed_klass.controller_name, managed_controller)
    managed_classes.push(managed_klass)
    managed_controllers.push(managed_controller)
  end

  def self.discard_managed_class(klass)
    managed_classes.each do |managed_class|
      if klass == managed_class.klass
        managed_controllers.reject! do |controller|
          controller.to_s == "Admin::#{managed_class.controller_name}"
        end
        ::Admin.send(:remove_const, managed_class.controller_name)
        managed_classes.delete(managed_class)
        return true
      end
    end
    return false
  end

  def self.reload_app_folder!
    Dir["#{Rails.root}/app/models/*.rb", "#{Rails.root}/app/admin/*.rb"].each do |file|
      load file
    end
  end

end
