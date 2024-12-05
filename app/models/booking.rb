class Booking < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  validates :start_date, :end_date, presence: true
  validate :start_date_before_end_date
  validate :no_overlapping_bookings

  enum status: { pending: 'pending', accepted: 'accepted', refused: 'refused' }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= 'pending'
  end

  def start_date_before_end_date
    return if start_date < end_date

    errors.add(:end_date, "must be after the start date")
  end

  def no_overlapping_bookings
    overlapping = apartment.bookings.where.not(id: id).where(
      "start_date < ? AND end_date > ?", end_date, start_date
    )
    return if overlapping.none?

    errors.add(:base, "Booking dates overlap with another booking")
  end

end
