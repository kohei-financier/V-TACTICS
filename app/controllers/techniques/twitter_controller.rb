class Techniques::TwitterController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def new
    @technique = Technique.new(source_type: "twitter")
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    @technique.source_type = "twitter"
    category_names = params[:technique][:category_names]

    if @technique.save
      if category_names.present?
        categories = category_names.split(",").map(&:strip).uniq
        create_or_update_technique_categories(@technique, categories)
      end
      redirect_to techniques_twitter_path(@technique), success: t("defaults.flash_message.created", item: "Xの#{Technique.model_name.human}")
    else
      flash.now[:error] = t("defaults.flash_message.not_created", item: Technique.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @technique = Technique.find(params[:id])
    recommend_id = Technique.where(source_type: "twitter").where.not(id: @technique.id).pluck(:id).sample(2)
    @recommend_techniques = Technique.where(id: recommend_id)
  end

  def edit
    @technique = current_user.techniques.find(params[:id])
  end

  def update
    @technique = current_user.techniques.find(params[:id])
    category_names = params[:technique][:category_names]

    if @technique.update(technique_params)
      if category_names.present?
        categories = params[:technique][:category_names].split(",").map(&:strip).uniq
        create_or_update_technique_categories(@technique, categories)
      end
      redirect_to techniques_twitter_path(@technique), success: t("defaults.flash_message.updated", item: Technique.model_name.human)
    else
      flash.now[:error] = t("defaults.flash_message.not_updated", item: Technique.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    technique = current_user.techniques.find(params[:id])
    technique.destroy!
    redirect_to techniques_path, success: t("defaults.flash_message.deleted", item: Technique.model_name.human), status: :see_other
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :source_type, :source_url)
  end

  def create_or_update_technique_categories(technique, categories)
    technique.categories.destroy_all
    begin
      categories.each do |category|
        category = Category.find_or_create_by(name: category)
        technique.categories << category
      rescue ActiveRecord::RecordInvalid
        false
      end
    end
  end
end
