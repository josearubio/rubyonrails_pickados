class Pick < ActiveRecord::Base
  belongs_to :user

  scope :top, joins('left join favby on fadvy.pick_id = picks.pick_id').
                select('picks.*, count(fadvy.id) as fadby_count').
                group('picks.id').
                order('fadby_count desc')

  has_many :passive_favorites, class_name:  "Favorite",
           foreign_key: "pick_id",
           dependent:   :destroy
  has_many :favby, through: :passive_favorites, source: :user

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
	validates :evento, presence: true ,length: { maximum: 75 }
	validates :pronostico, presence: true
  validates :categoria, presence: true
  validates :deporte, presence: true
  validates :cuota, presence: true
  validates :stake, presence: true
  validates :pickdate, presence: true
  validates :bookie, presence: true

  def setstarted
    update_attribute(:status,'started')
  end

  def setticked(result)
    update_attribute(:status,'ticked')
    update_attribute(:result, result)
  end

  def reportpick
    update_attribute(:report, true)
  end

  def favedby?(user)
  favby.include?(user)
  end
  #Registra la apuesta en las estadisticas de usuario
  def addonstats

    #Si no existe la estadistica mensual se crea, y si existe se devuelva ésta
    @stat = self.user.create_stat_if_not(created_at)

    #Modificamos total de picks, total de stake, total de cuota y media de cuota
    @stat.update_attribute(:totalpicks,@stat.totalpicks+=1)
    @stat.update_attribute(:totalstaked,@stat.totalstaked + self.stake)
    @stat.update_attribute(:totalcuota,@stat.totalcuota + self.cuota)
    @stat.update_attribute(:cuotaavg,@stat.totalcuota/@stat.totalpicks)

    #Según el pick sea verde rojo o azul tocamos el resto de estadísticas para modificar el yield y el profit
    if self.result=='ok'
      @stat.update_attribute(:acertadas, @stat.acertadas+=1)
      @auxprofit = self.stake*self.cuota-self.stake
      @stat.update_attribute(:profit,@stat.profit+@auxprofit)
    elsif self.result=='fail'
      @stat.update_attribute(:falladas, @stat.falladas+=1)
      @auxprofit = self.stake
      @stat.update_attribute(:profit,@stat.profit-@auxprofit)
    else
      @stat.update_attribute(:anuladas, @stat.anuladas+=1)
    end

    @stat.update_attribute(:yield, @stat.profit/@stat.totalstaked*100)

  end
end
