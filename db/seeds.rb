# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Item.destroy_all
# Feed.destroy_all

Feed.create([
  # {
  #   url: 'https://fakeurl12334334345.com/',
  # },
  {
    url: 'https://news.tut.by/rss/all.rss',
    interval_seconds: 61,
    should_fetch: false
  },
  {
    url: 'https://news.tut.by/rss/accidents.rss',
    interval_seconds: 61,
    # should_show: false
  },
  { url: 'https://varlamov.ru/data/rss'},
  { url: 'https://www.mrmoneymustache.com/feed/' }
])

Feed.create(
  ['https://varlamov.ru/data/rss', 'https://www.mrmoneymustache.com/feed/']
  .map! { |item| { url: item } }
)

lj = ['4140093', 'akuklev', 'berdasov.online', 'blondes_balkans', 'dzhin_dzhit', 'evgenia_shato', 'hrtdnv', 'inv2004', 'lana_sator', 'lexa', 'macroevolution', 'margot_yyc', 'megapotam', 'metaller', 'morsya', 'out_most', 'ovel', 'puerrtto', 'revliscap', 'slach', 'sovenok101', 'ufm', 'vadim88', 'vekna', 'w00dy', 'ximaera', '0ratoria', '109', '13', '32bit_me', '3jia5l_ca6aka', 'a_n_d_r_u_s_h_a', 'aleks_driver', 'alex_avr2', 'alex_radko', 'alexkuklin', 'aliaksei', 'amarao_san', 'ammo1', 'anlazz', 'anonim_legion', 'antigona88', 'antontsau', 'aquatek_filips', 'aslan', 'aterentiev', 'avr_mag', 'bigmaxx', 'binf', 'bitoniau', 'black_angel_by', 'boot_from_cd', 'brat_luber', 'bruzh', 'bydlorus', 'bzikoleaks', 'chich8', 'chronograph', 'cottidianus', 'cross_join', 'dadv', 'de_nada', 'deka', 'dennab', 'devnu11', 'di_halt', 'dil', 'dima_chatrov', 'dimas', 'dma', 'dmih', 'dottedmag', 'dr_mart', 'e_kaspersky', 'eternal_leave', 'evil_invader', 'feldgendler', 'fintraining', 'flavorchemist', 'frasl', 'glebarhangelsky', 'goldenkokos', 'golos_dobra', 'golosptic', 'gray_bird', 'idollisimo', 'ikaktys', 'ingaret', 'iron_bug', 'jakobz', 'jamhed', 'justy_tylor', 'kaa_mmf', 'katokdima', 'keinkeinkein', 'kincajou', 'kiss_my_abs', 'kohaku_no_neko', 'kong_en_ge', 'kotokhira', 'lazy_flyer', 'le_milady', 'levgem', 'litvin_v', 'lobzik84', 'loco_bird', 'masacra', 'maxim', 'maxim_nm', 'mend0za', 'mich_punk', 'micolik', 'miumau', 'mr_s_o_u_l', 'mudasobwa', 'natallia_psyh', 'nge_sachiel', 'nicka_startcev', 'nikolagrek', 'norguhtar', 'nponeccop', 'nzeemin', 'olegmakarenko.ru', 'olley', 'oyx', 'panchul', 'pbl', 'pessimist2006', 'prosto_vova', 'prostonata', 'psilogic', 'psilonsk', 'pustoshit', 'ramlamyammambam', 'rbs_vader', 'rotten_k', 'russos', 'sbj_ss', 'scarab', 'scorpikoshka', 'sergeydolya', 'shkrobius', 'sigmaray', 'sobaka_by', 'soliaris', 'sorhed', 'stogova', 'sv_loginow', 'svictorych', 'swizard', 'technic_man', 'techquisitor', 'tema', 'theiced', 'tobotras', 'tomkad', 'tonsky', 'transphoto2007', 'tretiy3', 'veter_r_r', 'victogan', 'victorborisov', 'vit_r', 'vital_x', 'vitmain', 'vitus_wagner', 'vladicusmagnus', 'web_man_zj', 'wizzard0', 'xpyctman', 'yozas_gubka', 'yury_nesterenko', 'zmila', 'scinquisitor']
lj.map! { |item| { url: "https://#{item}.livejournal.com/data/rss" } }
Feed.create(lj)
