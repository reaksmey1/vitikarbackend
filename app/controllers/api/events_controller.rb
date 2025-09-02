class Api::EventsController < Api::BaseController
  before_action :authenticate_request, except: [ :index, :show ]

  def index
    events = Event.includes(:organizer, gallery_images_attachments: :blob).all

    if params[:is_popular].present?
      events = Event.where(is_popular: params[:is_popular])
    end

    if params[:is_feature].present?
      events = Event.where(is_feature: params[:is_feature])
    end

    render json: events.map { |event| event_response(event) }
  end

  def show
    event = Event.find(params[:id])
    render json: event_response(event)
  end

  def create
    return render json: { error: "Unauthorized" }, status: :unauthorized unless current_user

    event = current_user.events.build(event_params)

    if event.save
      if params[:gallery_images].present?
        params[:gallery_images].each do |img|
          event.gallery_images.attach(img)
        end
      end

      render json: event_response(event), status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.permit(:name, :event_type, :description, :start_time, :end_time, :address, :location, :event_date, :price, :main_image, gallery_images: [])
  end

  def event_response(event)
    {
      id: event.id,
      name: event.name,
      event_type: event.event_type,
      description: event.description,
      address: event.address,
      location: event.location,
      event_date: event.event_date.strftime("%A, %d %b %Y"),
      start_time: event.start_time,
      end_time: event.end_time,
      price: event.price.to_s,
      is_popular: event.is_popular,
      is_feature: event.is_feature,
      organizer: {
        id: event.organizer.id,
        email: event.organizer.email
      },
      main_image: event.main_image_url,
      gallery_images: event.gallery_image_urls
    }
  end
end
