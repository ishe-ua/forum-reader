# coding: utf-8
# Рассписание для Letter.
#
# Т.е. в какие дни недели и в какое время доставлять.
#
# Поля в таблице:
# * day (1..7)
# * hour
# * minute
#
module Schedule
  extend ActiveSupport::Concern

  ## Доступные часы.
  HOURS = (0..23).to_a

  ## Доступные минуты.
  MINUTES = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55].freeze

  included do
    after_initialize :set_default_schedule

    validates :hour, presence: true, inclusion: { in: HOURS }
    validates :minute, presence: true, inclusion: { in: MINUTES }
  end

  ## Переводим час в Timezone пользователя.
  def hour_in_user_timezone
    Time.utc(2014, 9, 18, hour)
        .in_time_zone(user.timezone)
        .hour
  end

  protected

  ## Значение по умолчанию.
  def set_default_schedule
    self.d6 = true if d6.nil?
    self.hour ||= 0
    self.minute ||= 0
  end
end
