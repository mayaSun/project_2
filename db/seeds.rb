# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Web Owner', email: 'sarahbelloch@gmail.com', password: 'admin', role: 'admin')
User.create(name: 'Web Owner', email: 'israelholyherbs@gmail.com', password: 'admin', role: 'admin')
User.create(name: 'Web Builder', email: 'maya166@gmail.com', password: 'admin', role: 'shop_owner')
User.create(name: 'Example User', email: 'user@example.com', password: 'password')

Category.create(name: 'טיפוח קוסמטי', english_name: 'cosmetics')
Category.create(name: 'מזון רפואי', english_name: 'medicinal food')

Category.create(
  name: 'חליטות צמחים', 
  english_name: 'herbal infusions',
  image: open("public/images/category-imgs/tahini.jpg"),
  description: 'טחינה בארכה מיוצרת בתהליך טבעי לחלוטין, בטכנולוגיה של אבני ריחיים אשר טוחנות את השומשום לטחינה גולמית איכותית וטעימה. בסידרה 3 מוצרי טחינה גולמית הכוללים תיבול ייחודי כמיטב המסורת הערבית.')

Category.create(
  name: 'טחינה', 
  english_name: 'tahini', 
  category: Category.find_by(english_name: 'Medicinal Food'), 
  image: open("public/images/category-imgs/tahini.jpg"), 
  description: 'טחינה בארכה מיוצרת בתהליך טבעי לחלוטין, בטכנולוגיה של אבני ריחיים אשר טוחנות את השומשום לטחינה גולמית איכותית וטעימה. בסידרה 3 מוצרי טחינה גולמית הכוללים תיבול ייחודי כמיטב המסורת הערבית.')

Product.create(name: 'טחינה אתיופית',
  english_name: 'ethiopian tahini', 
  short_description: 'טחינה אתיופית משומשום מלא טרום מונבט', 
  long_description: 'הטחינה האתיופית של משק לין מיוצרת משומשום מלא, מזן אתיופי מובחר. השומשום עובר תהליך קצר של טרום הנבטה ולאחר מכן ייבוש וטחינה באבן רייחים בכבישה קרה. הטחינה עשירה מאוד במינרלים חיוניים כמו סידן, ברזל, מגנזיום ואשלגן. הטחינה עשירה בסיבים תזונתיים ובנוגדי חמצון. בטחינה גולמית נוצרת עם הזמן הפרדה בין שמן השומשום לחומר היבש ולכן מומלץ לערבב לפני השימוש', 
  use_instructions: 'ערבב עם מיים, שום ולימון', 
  ingridience: '100% שומשום אתיופי חצי מונבט', 
  price: '26.5', 
  stock: '70', 
  category: Category.find_by(english_name: 'Tahini'), 
  image: open("public/images/product-imgs/1.jpg"), 
  warnings: 'לא מומלץ לנשים בהריון',
  quantity: '330',
  quantity_unit: 'מ"ל',
  package_weight: '1', 
  energy: '621',
  carbohydrates: '3',
  protein: '21.2',
  fat: '58.2',
  saturated_fat: '0',
  cholesterol: '7',
  sodium: '5.4',
  other_nutrients: 'סיבים תזונתיים 12.4 גרם ,נתרן 5.4 גרם, סידן 854 גרם, ברזל 29 גרם, מגנזיום 245 גרם ,אשלגן 725')

MedicinalHerb.create(
  name: 'אבגר צהוב', 
  english_name: 'agronomy', 
  latin_name: 'agrimonia eupatoria L' , 
  description: 'מקורו של הצמח, המשתייך למשפחת השפתניים, במזרח התיכון ובדרום צרפת והוא נפוץ כגידול מסחרי בארצות רבות. אגדות רבות נפוצו על אודותיו של צמח רב שנתי זה, הידוע גם כ"צמח הזיכרון". מלומדים יוונים נהגו להניח מעט רוזמרין בשערם בזמן למידה, לצורך שיפור יכולת הריכוז. הצמח הריחני הוחלף בין חברים כסמל לנאמנות ואף נזרק על קברם של מתים. במצרים העתיקה נקברו הפרעונים עם הצמח.בארצות שונות רווחה האמונה כי לרוזמרין כוחות מאגיים ויכולת לגרש שדים. הצמח נשרף בחדרי חולים כמחטא והשתמשו בו בניסיון להדוף מגפות. השמן הנדיף הינו המרכיב החשוב בצמח, והוא מכיל Rosemary Camphor. לחומר זה מיוחסת השפעה כללית מחזקת על מחזור הדם ועל מערכת העצבים, בעיקר בחלקיה האחראים על עצבוב כלי-הדם. ברפואת הצמחים המודרנית נחשב הרוזמרין לבעל עוצמת פעילות בינונית, והוא מותווה בעיקר למצבים של חולשה הנזקקים לתמיכה ולהמרצה', 
  medicinal_properties: 'מיצוי מיימי של כל חלקי הצמח, יעזור במקרה של שריטות ופצעים. משרה מעלי האבגר תעזור לטפל בדלקות כיבה ושלפוחית השטן. נחשב למטפל קל בשלשול אצל ילדים. ניתן לגרגר את המשרה במקרים של כאב גרון והצטברות ליחה בדרכי הנשימה. ע"פ תורת החתימות מפורסם האבגר לטיפול בצהבת. שימושים נילווים האבגר משמר להפקת צבע צהוב לצביעת עורות ובגדים. ', 
  image: open("public/images/herb-imgs/from-web/Agrimonia.jpg"))

MedicinalHerb.create(
  name: 'אבטיח  הפקועה', 
  english_name: 'bitter cucumber', 
  latin_name: 'citrullus colocynthis (L) shard' , 
  description: '????', 
  medicinal_properties: 'מטפל בדרכי השתן והכבד, הפרי נחשב לסם משלשל חזק, משמש לשיכוך כאבי שרירים ושיגרון. הפרחים המעוכים משמשים לשיכוך כאבי שיניים, השורש כשהוא מרוסק במלחמשמש לשיכוך כאבי ראש. מהזרעים ניתן להכין שמן אשר מותר ע"פ המשנה לנרות שבת. ע"פ יהדות תימן בליעת זרע ליום למשך 21 יום יועיל לסכרת.', 
  use_instructions: 'השימוש באמצעות אידוי ובשימוש חצוני להדק חתיכות מציפת הפרי למקום הכואב.', 
  warnings: 'אכילת הפרי עלולה לפגוע במעיים לגרום לאפיסת כוחות ולשטפי דם במערכת העיכול.
אסור לנשים בהריון.', 
  image: open("public/images/herb-imgs/from-web/citrullus_colocynthis7c_h_zell.jpg"))

MedicinalHerb.create(
  name: 'אגרופירון זוחל', 
  english_name: 'couchgrass', 
  latin_name: 'Agropyrum Repens (L.) P.Beauv',
  image: open("public/images/herb-imgs/from-web/Agropyrum Repens (L.) P.Beauv.jpg"))

MedicinalHerb.create(
  name: 'אוג הבורסקאים', 
  english_name: 'sumach', 
  latin_name: 'Rhus coriaria L.',
  image: open("public/images/herb-imgs/from-web/Rhus coriaria L..jpg"))

MedicinalHerb.create(
  name: 'אזוב מצוי', 
  english_name: 'syrian majoram', 
  latin_name: 'Majorana Syriaca (L.) Raif',
  image: open("public/images/herb-imgs/kd/Majorana Syriaca.jpg"))

MedicinalHerb.create(
  name: 'אטד אירופי', 
  english_name: 'Lycium earopaeum L.', 
  latin_name: 'Lycium earopaeum',
  image: open("public/images/herb-imgs/from-web/Lycium earopaeum.jpg"))

MedicinalHerb.create(
  name: 'אכיליאה ריחנית', 
  english_name: 'Achillea fragrantissima', 
  latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip')

MedicinalHerb.create(
  name: 'אלון התבור', 
  english_name: 'oak', 
  latin_name: 'Quercus ithaburensis',
  image: open("public/images/herb-imgs/kd/Quercus ithaburensis.jpg"))

MedicinalHerb.create(
  name: 'אלון מצוי', 
  english_name: 'oak', 
  latin_name: 'Quercus calliprinos Webb',
  image: open("public/images/herb-imgs/kd/Quercus calliprinos Webb.jpg"))

MedicinalHerb.create(
  name: 'אלמות הכסף', 
  english_name: 'Paronychila argentea', 
  latin_name: 'Paronychila argentea Lam.',
  image: open("public/images/herb-imgs/from-web/Paronychila argentea .jpg"))

MedicinalHerb.create(
  name: 'אלת המסטיק', 
  english_name: 'mastic', 
  latin_name: 'Pistacia lentiscus L.',
  image: open("public/images/herb-imgs/from-web/Pistacia lentiscus.jpg"))

MedicinalHerb.create(
  name: 'אמיתה גדולה', 
  english_name: "bishop's weed", 
  latin_name: 'Ammi majus L.',
  image: open("public/images/herb-imgs/kd/Ammi majus .jpg"))

MedicinalHerb.create(
  name: 'אמיתה קיצית', 
  english_name: 'khella', 
  latin_name: 'Ammi visnaga (L.) Lam.',
  image: open("public/images/herb-imgs/from-web/Ammi visnaga.jpg"))

MedicinalHerb.create(
  name: 'ארכבית הצפרים', 
  english_name: 'knotgrass', 
  latin_name: 'Polygonum arenastrum Bor.',
  image: open("public/images/herb-imgs/from-web/Polygonum arenastrum.jpg"))

MedicinalHerb.create(
  name: 'בבונג זהב', 
  english_name: 'chamomile', 
  latin_name: 'Matricaria aurea (Loefi.) Sch. Bip',
  image: open("public/images/herb-imgs/from-web/Matricaria aurea.jpg"))

MedicinalHerb.create(
  name: 'בוצין המדבר', 
  english_name: 'mullein', 
  latin_name: 'Verbascum eremobium Murb.',
  image: open("public/images/herb-imgs/from-web/Verbascum eremobium .jpg"))

MedicinalHerb.create(
  name: 'גד השדה', 
  english_name: 'coriander', 
  latin_name: 'Coriandrum sativum L.',
  image: open("public/images/herb-imgs/from-web/Coriandrum sativum.jpg"))

MedicinalHerb.create(
  name: 'גדילן מצוי', 
  english_name: 'milk thistlr', 
  latin_name: 'Silybum marianum (L.) Gaerth',
  image: open("public/images/herb-imgs/from-web/Silybum marianum.jpg"))

MedicinalHerb.create(
  name: 'גזר הגינה', 
  english_name: 'wild carrot', 
  latin_name: 'Daucus carota L.',
  image: open("public/images/herb-imgs/from-web/Daucus carota.jpg"))

MedicinalHerb.create(
  name: 'גמא הפקעים', 
  english_name: 'nut-Grass, Sedge', 
  latin_name: 'Cyperus rotundus L.',
  image: open("public/images/herb-imgs/from-web/Cyperus rotundus.jpg"))

MedicinalHerb.create(
  name: 'געדה מצויה', 
  english_name: 'germander', 
  latin_name: 'Teucrium polium L.',
  image: open("public/images/herb-imgs/from-web/Teucrium polium .jpg"))

MedicinalHerb.create(
  name: 'גרגרנית יונית', 
  english_name: 'fenugreek', 
  latin_name: 'Trigonella foenum-graceum L.',
  image: open("public/images/herb-imgs/from-web/Trigonella foenum-graceum.jpg"))

MedicinalHerb.create(
  name: 'דבקה זיפנית', 
  english_name: 'cleavers', 
  latin_name: 'Galium aparine L.',
  image: open("public/images/herb-imgs/from-web/Galium aparine.jpg"))

MedicinalHerb.create(
  name: 'דודא רפואי', 
  english_name: 'mandrake', 
  latin_name: 'Mandragora autumnalis Bertol.',
  image: open("public/images/herb-imgs/from-web/Mandragora autumnalis .jpg"))

MedicinalHerb.create(
  name: 'דושן שעיר', 
  english_name: 'Bidens pilosa L.', 
  latin_name: 'Bidens pilosa',
  image: open("public/images/herb-imgs/from-web/Bidens pilosa.jpg"))

MedicinalHerb.create(
  name: 'דטורה זקופת-פרי', 
  english_name: 'jimsonweed', 
  latin_name: 'Datura stramonium L.',
  image: open("public/images/herb-imgs/from-web/Datura stramonium.jpg"))

MedicinalHerb.create(
  name: 'הגה מצוי', 
  english_name: 'alhagi manna', 
  latin_name: 'Alhagi maurorum Melik',
  image: open("public/images/herb-imgs/from-web/Alhagi maurorum Medik.jpg"))

MedicinalHerb.create(
  name: 'הדס מצוי', 
  english_name: 'myrtle', 
  latin_name: 'Myrtus commuins L.',
  image: open("public/images/herb-imgs/kd/Myrtus commuins.jpg"))

MedicinalHerb.create(
  name: 'הרדוף הנחלים', 
  english_name: 'oleander, rose bay', 
  latin_name: 'Nerium oleander L.',
  image: open("public/images/herb-imgs/kd/Nerium oleander .jpg"))

MedicinalHerb.create(
  name: 'ויתניה משכרת', 
  english_name: 'Withania somnifera', 
  latin_name: 'Withania somnifera (L.) Dun.',
  image: open("public/images/herb-imgs/from-web/Withania somnifera.jpg"))

MedicinalHerb.create(
  name: 'ורבנה רפואית', 
  english_name: 'herb of the cross verain herb', 
  latin_name: 'Verbena officinalis L.',
  image: open("public/images/herb-imgs/from-web/Verbena Officinalis.jpg"))

MedicinalHerb.create(
  name: 'ורד הכלב', 
  english_name: 'rose hips', 
  latin_name: 'Rosa canina L.',
  image: open("public/images/herb-imgs/from-web/Rosa canina.jpg"))

MedicinalHerb.create(
  name: 'זוטה לבנה', 
  english_name: 'Micromeria fruticosa (L.) Druce', 
  latin_name: 'Thyme-Leaved Savory',
  image: open("public/images/herb-imgs/from-web/Thymelaea hirsuta .jpg"))

MedicinalHerb.create(
  name: 'זית אירופי', 
  english_name: 'olive', 
  latin_name: 'Olea europae L.',
  image: open("public/images/herb-imgs/kd/Olea europae.jpg"))

MedicinalHerb.create(
  name: 'זקום מצרי', 
  english_name: 'Balanites aegyptiaca', 
  latin_name: 'Balanites aegyptiaca (L.) Del.',
  image: open("public/images/herb-imgs/from-web/Balanites aegyptiaca  .jpg"))

MedicinalHerb.create(
  name: 'חלמית מצויה', 
  english_name: 'mallow', 
  latin_name: 'Malva nicaeensis All.',
  image: open("public/images/herb-imgs/from-web/Malva nicaeensi.jpg"))

MedicinalHerb.create(
  name: 'חמעה ורדה', 
  english_name: 'Rumex cyprius', 
  latin_name: 'Rumex cyprius Murb',
  image: open("public/images/herb-imgs/from-web/Rumex cyprius  .jpg"))

MedicinalHerb.create(
  name: 'חצב מצוי', 
  english_name: 'squill', 
  latin_name: 'Urginea maritima (L.) Bak.',
  image: open("public/images/herb-imgs/from-web/Urginea maritima .jpg"))

MedicinalHerb.create(
  name: 'חרדל לבן', 
  english_name: 'white mustard', 
  latin_name: 'Sinapis alba L.',
  image: open("public/images/herb-imgs/kd/Sinapis alba.jpg"))

MedicinalHerb.create(
  name: 'חרוב מצוי', 
  english_name: "john's bread", 
  latin_name: 'Ceratonia siliqua L.',
  image: open("public/images/herb-imgs/kd/Ceratonia siliqua.jpg"))

MedicinalHerb.create(
  name: 'חרחבינה מכחילה', 
  english_name: 'eryngo', 
  latin_name: 'Eryngium creticum Lam',
  image: open("public/images/herb-imgs/from-web/Eryngium creticum  .jpg"))

MedicinalHerb.create(
  name: 'חרצית עטורה', 
  english_name: 'Chrysanthemum coronarium', 
  latin_name: 'Chrysanthemum coronarium L.',
  image: open("public/images/herb-imgs/from-web/Chrysanthemum coronarium .jpg"))

MedicinalHerb.create(
  name: 'טיון דביק', 
  english_name: 'elecampane', 
  latin_name: 'Inula viscosa (L.) Ait.',
  image: open("public/images/herb-imgs/from-web/Inula viscosa  .jpg"))

MedicinalHerb.create(
  name: 'ילקוט הרועים', 
  english_name: "shepherd's purse", 
  latin_name: 'Capsella bursa-pastoris (L.) Medik',
  image: open("public/images/herb-imgs/from-web/Capsella bursa-pastoris .jpg"))

MedicinalHerb.create(
  name: 'ינבוט השדה', 
  english_name: 'Prosopis farcta', 
  latin_name: 'Prosopis farcta (Banks et Sol) Macbride.',
  image: open("public/images/herb-imgs/from-web/Prosopis farcta.jpg"))

MedicinalHerb.create(
  name: 'יפרוק המדבר', 
  english_name: 'Anabasis articulata', 
  latin_name: 'Anabasis articulata (Forssk) Moq.',
  image: open("public/images/herb-imgs/from-web/Anabasis articulata.jpg"))

MedicinalHerb.create(
  name: 'ירבוז מפשל', 
  english_name: 'Amaranthus retroflexus', 
  latin_name: 'Amaranthus retroflexus L.',
  image: open("public/images/herb-imgs/from-web/Amaranthus retroflexus.jpg"))

MedicinalHerb.create(
  name: 'ירקת החמור', 
  english_name: 'Ecballium elateruim (L.) ich', 
  latin_name: 'squiriting cucumber',
  image: open("public/images/herb-imgs/from-web/Ecballium Elateruim .jpg"))

MedicinalHerb.create(
  name: 'כסיה מדברית', 
  english_name: 'senna leaf, senna pods', 
  latin_name: 'Cassia italica (Mill) Lam.',
  image: open("public/images/herb-imgs/from-web/Cassia italica .jpg"))

MedicinalHerb.create(
  name: 'כף אוז ריחנית', 
  english_name: 'american wormseed', 
  latin_name: 'Chenopodium ambrosioides L.',
  image: open("public/images/herb-imgs/from-web/Chenopodium ambrosioides  .jpg"))

MedicinalHerb.create(
  name: 'כרפס ריחני', 
  english_name: 'celery', 
  latin_name: 'Apium graveolens L.',
  image: open("public/images/herb-imgs/kd/Apium graveolens.jpg"))

MedicinalHerb.create(
  name: 'כתלה חריפה', 
  english_name: 'Varthemia iphionoides', 
  latin_name: 'Varthemia iphionoides. Boiss et Bl.',
  image: open("public/images/herb-imgs/from-web/Varthemia iphionoides .jpg"))

MedicinalHerb.create(
  name: 'לחך סגלגל', 
  english_name: 'Blond psyllium, inspaghula', 
  latin_name: 'Plantago ovata Forssk',
  image: open("public/images/herb-imgs/from-web/Plantago ovata.jpg"))

MedicinalHerb.create(
  name: 'לענת המדבר', 
  english_name: 'Artemisia herba-alba Asso', 
  latin_name: 'Artemisia herba-alba Asso',
  image: open("public/images/herb-imgs/from-web/Artemisia herba-alba Asso.jpg"))

MedicinalHerb.create(
  name: 'לשון-פר סמורה', 
  english_name: 'Anchusa strigasa Bank et Sol', 
  latin_name: 'Anchusa strigasa',
  image: open("public/images/herb-imgs/from-web/Anchusa strigasa  .jpg"))

MedicinalHerb.create(
  name: 'מלוח קפח', 
  english_name: 'Saltbush', 
  latin_name: 'Artiplex halimus L.',
  image: open("public/images/herb-imgs/from-web/Artiplex halimus .jpg"))

MedicinalHerb.create(
  name: 'מלסה רפואית', 
  english_name: 'lemon balm', 
  latin_name: 'Melissa officinalis L.',
  image: open("public/images/herb-imgs/kd/Melissa officinalis .jpg"))

MedicinalHerb.create(
  name: 'מרביון מצויד', 
  english_name: 'horehound', 
  latin_name: 'Marrubium vulgare L.',
  image: open("public/images/herb-imgs/from-web/Marrubium vulgare  .jpg"))

MedicinalHerb.create(
  name: 'מרוה משלשת', 
  english_name: 'three lobed sage', 
  latin_name: 'Salvia fruticosa Mill.',
  image: open("public/images/herb-imgs/kd/Salvia fruticosa.jpg"))

MedicinalHerb.create(
  name: 'משין גלילי', 
  english_name: 'Alang-Alang, Thatch Grass', 
  latin_name: 'Imperata cylindrica (L.) P. Beauv.',
  image: open("public/images/herb-imgs/from-web/Imperata cylindrica  .jpg"))

MedicinalHerb.create(
  name: 'מתנן שעיר', 
  english_name: 'Thymelaea hirsuta', 
  latin_name: 'Thymelaea hirsuta (L.) Endl',
  image: open("public/images/herb-imgs/from-web/Thymelaea hirsuta .jpg"))

MedicinalHerb.create(
  name: 'נטופית רפואית', 
  english_name: 'marshmallow', 
  latin_name: 'Althea officinalis L.',
  image: open("public/images/herb-imgs/from-web/Althea officinalis .jpg"))

MedicinalHerb.create(
  name: 'נענת הכדורים', 
  english_name: 'pennyroyal', 
  latin_name: 'Mentha pulegium L.',
  image: open("public/images/herb-imgs/from-web/Mentha pulegium.jpg"))

MedicinalHerb.create(
  name: 'סביון פשוט', 
  english_name: 'groundsel', 
  latin_name: 'Senecio vugaris L.',
  image: open("public/images/herb-imgs/from-web/Senecio vugaris.jpg"))

MedicinalHerb.create(
  name: 'סולנום שחור', 
  english_name: 'black nightshade', 
  latin_name: 'Solanum nigrum L.',
  image: open("public/images/herb-imgs/from-web/Solanum nigrum.jpg"))

MedicinalHerb.create(
  name: 'סירה קוצנית', 
  english_name: 'prickly shrubby burnrt', 
  latin_name: 'Sarcopoterium spinosum (L.) Sp.',
  image: open("public/images/herb-imgs/from-web/Sarcopoterium spinosum.jpg"))

MedicinalHerb.create(
  name: 'סרפד הכדורים', 
  english_name: 'roman nettle', 
  latin_name: 'Uritca pilulifera L.',
  image: open("public/images/herb-imgs/from-web/Uritca pilulifera.jpg"))

MedicinalHerb.create(
  name: 'עזרר קוצני', 
  english_name: 'Crataegus aronia', 
  latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.',
  image: open("public/images/herb-imgs/kd/Crataegus aronia.jpg"))

MedicinalHerb.create(
  name: 'עירית גדולה', 
  english_name: 'asphodel', 
  latin_name: 'Asphodelus microcarpus Slazm & Viv.',
  image: open("public/images/herb-imgs/from-web/Asphodelus microcarpus .jpg"))

MedicinalHerb.create(
  name: 'עצבונית החרש', 
  english_name: "butcher's broom", 
  latin_name: "butcher's aculeatus L.")

MedicinalHerb.create(
  name: 'ער אציל', 
  english_name: 'laurel, bay', 
  latin_name: 'Laurus nobilis L.',
  image: open("public/images/herb-imgs/kd/Laurus nobilis.jpg"))

MedicinalHerb.create(
  name: 'ערבה לבנה', 
  english_name: 'white willow', 
  latin_name: 'Salix alba L.',
  image: open("public/images/herb-imgs/from-web/Salix alba.jpg"))

MedicinalHerb.create(
  name: 'פיגם מצוי', 
  english_name: 'rue', 
  latin_name: 'Ruta chalepensis L.',
  image: open("public/images/herb-imgs/from-web/Ruta chalepensis.jpg"))

MedicinalHerb.create(
  name: 'פיגמית מגבששת', 
  english_name: 'Haplophyllum tuberculatum', 
  latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.',
  image: open("public/images/herb-imgs/from-web/Haplophyllum tuberculatum.jpg"))

MedicinalHerb.create(
  name: 'פרגה צהבה', 
  english_name: 'yellow horned poppy', 
  latin_name: 'Glaucium flavum Crantz',
  image: open("public/images/herb-imgs/from-web/Glaucium flavum    .jpg"))

MedicinalHerb.create(
  name: 'פתילת המדבר הגדולה', 
  english_name: 'apple of sodom', 
  latin_name: 'Calotropis procera (Ait.) Ait F.',
  image: open("public/images/herb-imgs/from-web/Calotropis procera.jpg"))

MedicinalHerb.create(
  name: 'צלף קוצני', 
  english_name: 'caper', 
  latin_name: 'Capparis spinosa L.',
  image: open("public/images/herb-imgs/kd/Capparis spinosa.jpg"))

MedicinalHerb.create(
  name: 'צתרה ורדה', 
  english_name: 'savory', 
  latin_name: 'Satureja thymbra L.',
  image: open("public/images/herb-imgs/from-web/Satureja thymbra .jpg"))

MedicinalHerb.create(
  name: 'קורנית מקרקפת', 
  english_name: 'wild thyme', 
  latin_name: 'Coridothymus capitatus (L.) Reichb',
  image: open("public/images/herb-imgs/kd/Coridothymus capitatus (L.) Reichb.jpg"))

MedicinalHerb.create(
  name: 'קיסוס החרש', 
  english_name: 'english Ivy', 
  latin_name: 'Herera helix L.',
  image: open("public/images/herb-imgs/kd/Herera helix.JPG"))

MedicinalHerb.create(
  name: 'קיקיון מצוי', 
  english_name: 'castor bean', 
  latin_name: 'Ricinus communis L.',
  image: open("public/images/herb-imgs/from-web/Ricinus communis   .jpg"))

MedicinalHerb.create(
  name: 'רגלת הגנה', 
  english_name: 'purslane', 
  latin_name: 'Portulaca oleracea L.',
  image: open("public/images/herb-imgs/from-web/Agrimonia.jpg"))

MedicinalHerb.create(
  name: 'רוזמרין רפואי', 
  english_name: 'rosemary', 
  latin_name: 'Rosmarinus officinalis' , 
  description: 'מקורו של הצמח, המשתייך למשפחת השפתניים, במזרח התיכון ובדרום צרפת והוא נפוץ כגידול מסחרי בארצות רבות. אגדות רבות נפוצו על אודותיו של צמח רב שנתי זה, הידוע גם כ"צמח הזיכרון". מלומדים יוונים נהגו להניח מעט רוזמרין בשערם בזמן למידה, לצורך שיפור יכולת הריכוז. הצמח הריחני הוחלף בין חברים כסמל לנאמנות ואף נזרק על קברם של מתים. במצרים העתיקה נקברו הפרעונים עם הצמח.בארצות שונות רווחה האמונה כי לרוזמרין כוחות מאגיים ויכולת לגרש שדים. הצמח נשרף בחדרי חולים כמחטא והשתמשו בו בניסיון להדוף מגפות. השמן הנדיף הינו המרכיב החשוב בצמח, והוא מכיל Rosemary Camphor. לחומר זה מיוחסת השפעה כללית מחזקת על מחזור הדם ועל מערכת העצבים, בעיקר בחלקיה האחראים על עצבוב כלי-הדם. ברפואת הצמחים המודרנית נחשב הרוזמרין לבעל עוצמת פעילות בינונית, והוא מותווה בעיקר למצבים של חולשה הנזקקים לתמיכה ולהמרצה', 
  medicinal_properties: 'מחזק, מחזק\מזין מערכת העצבים, מחזק לב, מייזע, ממריץ\מחמם, ממריץ קיבה, מעורר, מעלה לחץ דם, משפר זרימת דם היקפית', 
  use_instructions: 'טוב לחליטות , מצויין בטור שמן וממש טוב בתנור עפ תפוח אדמה', 
  warnings: 'לא מיועד לנשים בהריון', 
  image: open("public/images/herb-imgs/kd/Rosmarinus officinalis  .jpg"))

MedicinalHerb.create(
  name: 'רוש עקד', 
  english_name: 'poison hemlock', 
  latin_name: 'Conium maculatum L.',
  image: open("public/images/herb-imgs/from-web/Conium maculatum .jpg"))

MedicinalHerb.create(
  name: 'רקפת מצויה', 
  english_name: 'aleppo cyclamen', 
  latin_name: 'Cyclamen persicum Mill.',
  image: open("public/images/herb-imgs/from-web/Cyclamen persicum .jpg"))

MedicinalHerb.create(
  name: 'רתם המדבר', 
  english_name: 'white Broom', 
  latin_name: 'Retama raetam (Forssk.) Webb',
  image: open("public/images/herb-imgs/kd/Retama raetam.jpg"))

MedicinalHerb.create(
  name: 'שבר לבן', 
  english_name: 'common peganum', 
  latin_name: 'Peganum harmala L.',
  image: open("public/images/herb-imgs/from-web/Peganum harmala .jpg"))

MedicinalHerb.create(
  name: 'שבת ריחני', 
  english_name: 'dill', 
  latin_name: 'Anethum graveolens L.',
  image: open("public/images/herb-imgs/from-web/Anethum graveolens  .jpg"))

MedicinalHerb.create(
  name: 'שוש קרח', 
  english_name: 'Liquorice, Licorice', 
  latin_name: 'Glycyrrhiza glabra L.',
  image: open("public/images/herb-imgs/from-web/Glycyrrhiza glabra.jpg"))

MedicinalHerb.create(
  name: 'שיזף מצוי', 
  english_name: 'christ thorn', 
  latin_name: 'Ziziphos spina-christi (L.) Desf',
  image: open("public/images/herb-imgs/kd/Ziziphos spina-christi .jpg"))

MedicinalHerb.create(
  name: 'שיח-אברהם מצוי', 
  english_name: 'chaste tree', 
  latin_name: 'Vitex agnus-castus L.',
  image: open("public/images/herb-imgs/kd/Vitex agnus-castus.jpg"))

MedicinalHerb.create(
  name: 'שכרון זהב', 
  english_name: 'henbane', 
  latin_name: 'Hyoscyamus aureus L.',
  image: open("public/images/herb-imgs/from-web/Hyoscyamus aureus .jpg"))

MedicinalHerb.create(
  name: 'שמר פשוט', 
  english_name: 'fennel', 
  latin_name: 'Foeniculum vulgare Mill.',
  image: open("public/images/herb-imgs/from-web/Agrimonia.jpg"))

# Medical Activities

MedicalActivity.create(
  name: 'אבוד הכרה', 
  english_name: 'Loss Of Consciousness', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.')])
MedicalActivity.create(
  name: 'איבוד זיכרון', 
  english_name: 'Lost Memory', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.')])
MedicalActivity.create(
  name: 'אוזנים (שמיעה חלשה, חרשות, כאבים)', 
  english_name: 'ears disorders', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'),MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.')])
MedicalActivity.create(
  name: 'אין אונות', 
  english_name: 'impotence', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.')])
MedicalActivity.create(
  name: 'אנמיה', 
  english_name: 'anemia', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.')])
MedicalActivity.create(
  name: 'אסטמה (גנחת)', 
  english_name: 'asthma', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.')])
MedicalActivity.create(
  name: 'דימום מהאף', 
  english_name: 'Epistaxis', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'),MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.')])
MedicalActivity.create(
  name: 'כאבי בטן', 
  english_name: 'stomach ache', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Ammi visnaga (L.) Lam.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Ceratonia siliqua L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Amaranthus retroflexus L.')])
MedicalActivity.create(
  name: 'דלקת בבלוטות', 
  english_name: 'Inflammation of glands', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa')])
MedicalActivity.create(
  name: 'דלקת בלבלב', 
  english_name: 'Pancreatitis', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Galium aparine L.')])
MedicalActivity.create(
  name: 'דלקת בלימפה', 
  english_name: 'Strep lmpa', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Galium aparine L.')])
MedicalActivity.create(
  name: 'בלוטת המגן', 
  english_name: 'Thyroid', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Galium aparine L.')])
MedicalActivity.create(
  name: 'בלוטת הערמונית', 
  english_name: 'prostate', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Salix alba L.')])
MedicalActivity.create(
  name: 'בלוטת התריס', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Sinapis alba L.')] )
MedicalActivity.create(
  name: 'בצקת', 
  english_name: 'בצקת', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.')])
MedicalActivity.create(
  name: 'בקטריות', 
  english_name: 'bacterias', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
MedicalActivity.create(
  name: 'ברונכיט', 
  english_name: 'bronchitis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.')])
MedicalActivity.create(
  name: 'כאבי גב', 
  english_name: 'backache', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
MedicalActivity.create(
  name: 'גידולים סרטניים', 
  english_name: 'Cancerous tumors', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Nerium oleander L.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.')])
MedicalActivity.create(
  name: 'דלקות בגרון', 
  english_name: 'Throat infections', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'דיזנטריה', 
  english_name: 'dysentery', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Herera helix L.')] )
MedicalActivity.create(
  name: 'טיהור מערכת הדם', 
  english_name: 'Purification of circulatory system', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.')])
MedicalActivity.create(
  name: 'שטפי דם', 
  english_name: 'Bleeding', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik')])
MedicalActivity.create(
  name: 'דימום בכיבה', 
  english_name: 'Stomach bleeding', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz')])
MedicalActivity.create(
  name: 'הסתידות עוקרים', 
  english_name: 'arteriosclerosis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.')])
MedicalActivity.create(
  name: 'הצטננות (נזלת)', 
  english_name: 'cold', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Ceratonia siliqua L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Anchusa strigasa'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'לויקודרמה', 
  english_name: 'Vitiligo', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ammi majus L.')])
MedicalActivity.create(
  name: 'מחלת ורידים', 
  english_name: 'Venous disease', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.')])
MedicalActivity.create(
  name: 'זיבה', 
  english_name: 'gonorrhea', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Amaranthus retroflexus L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.')])
MedicalActivity.create(
  name: 'כאבים בחזה', 
  english_name: 'Chest pains', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'זיהום חידקי', 
  english_name: 'Microbic pollution', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Anethum graveolens L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'הורדת חום', 
  english_name: 'reduce fever', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Amaranthus retroflexus L.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
MedicalActivity.create(
  name: 'דלקת חניכיים', 
  english_name: 'gingivitis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam')])
MedicalActivity.create(
  name: 'חצבת', 
  english_name: 'measles', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')] )
MedicalActivity.create(
  name: 'טחול', 
  english_name: 'spleen', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'),MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'),MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'),MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik')] )
MedicalActivity.create(
  name: 'טחורים', 
  english_name: 'hemorrhoids', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Nerium oleander L.'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Anethum graveolens L.')])
MedicalActivity.create(
  name: 'טיפוס', 
  english_name: 'typhus', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.')])
MedicalActivity.create(
  name: 'טרשת ערקים', 
  english_name: 'atherosclerosis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.')])
MedicalActivity.create(
  name: 'כטרט', 
  english_name: 'aaa', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'יבלות', 
  english_name: 'Wart', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Nerium oleander L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.')])
MedicalActivity.create(
  name: 'רעידות ידיים', 
  english_name: 'essential tremors', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.')])
MedicalActivity.create(
  name: 'קטרקט', 
  english_name: 'cataract', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'בעיות בכבד', 
  english_name: 'liver', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Amaranthus retroflexus L.'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
MedicalActivity.create(
  name: 'כויות', 
  english_name: 'burns', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.')])
MedicalActivity.create(
  name: 'כויות שמש', 
  english_name: 'sunburn', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.')])
MedicalActivity.create(
  name: 'כלבת', 
  english_name: 'Rabies', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.')])
MedicalActivity.create(
  name: 'כליות (אבנים, דלקת חול)', 
  english_name: 'Kidney disorders', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Paronychila argentea Lam.'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Anchusa strigasa'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Imperata cylindrica (L.) P. Beauv.'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Portulaca oleracea L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'לב (מחלה, תעוקה)', 
  english_name: 'Heart disorders', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Paronychila argentea Lam.'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Nerium oleander L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Portulaca oleracea L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'לחץ דם', 
  english_name: 'Blood Pressure', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')] )
MedicalActivity.create(
  name: 'מחלות מין', 
  english_name: 'Sexually Transmitted Disease', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Olea europae L.')])
MedicalActivity.create(
  name: 'מחלות נפש', 
  english_name: 'Mental Disorder', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'דיכאון, מרה שחורה', 
  english_name: 'Major Depressive Disorder', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')])
MedicalActivity.create(
  name: 'היסטריה', 
  english_name: 'Hysteria', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
MedicalActivity.create(
  name: 'התקפי שיגעון', 
  english_name: ' Bouts Of Mania', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.')])
MedicalActivity.create(
  name: 'מלנכוליה', 
  english_name: 'Melancholy', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.')])
MedicalActivity.create(
  name: 'מחלות עצבים', 
  english_name: 'Neural Disorder', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')] )
MedicalActivity.create(
  name: ' אפילפסיה', 
  english_name: 'Epilepsy', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.')])
MedicalActivity.create(
  name: 'מימת', 
  english_name: 'Edema', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
MedicalActivity.create(
  name: 'דלקת מיתרי הקול', 
  english_name: 'Vocal Folds', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Galium aparine L.')])
MedicalActivity.create(
  name: 'מכת שמש', 
  english_name: 'Heatstroke', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.')])
MedicalActivity.create(
  name: 'מלריה', 
  english_name: 'Malaria', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip')])
MedicalActivity.create(
  name: 'מעיים  (דלקת, התכווצויות, כיב, תולעים)', 
  english_name: 'Intestinal disorders', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Anchusa strigasa'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
MedicalActivity.create(
  name: 'מרה (אבנים, דלקת)', 
  english_name: 'Gall disorders', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
MedicalActivity.create(
  name: 'נגיפים (וירוסים)', 
  english_name: 'Virus', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.')])
MedicalActivity.create(
  name: 'הכשת נחש', 
  english_name: 'Snake Bite', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thymelaea hirsuta (L.) Endl'),MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Nerium oleander L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.')])
MedicalActivity.create(
  name: 'נמק', 
  english_name: 'Necrosis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.')])
MedicalActivity.create(
  name: 'מערכת דרכי הנשימה', 
  english_name: 'Respiratory System', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thymelaea hirsuta (L.) Endl'),MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Ceratonia siliqua L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Anabasis articulata (Forssk) Moq.'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'סחרחורת', 
  english_name: 'Dizziness', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb')])
MedicalActivity.create(
  name: 'דלקת בסימפונות', 
  english_name: 'Bronchitis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'סכרת', 
  english_name: 'Diabetes Mellitus', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
MedicalActivity.create(
  name: 'עגבת', 
  english_name: 'Syphilis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.')] )
MedicalActivity.create(
  name: 'עויתות, פרכוסים', 
  english_name: 'Spasm', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
MedicalActivity.create(
  name: 'מחלות עור', 
  english_name: 'Skin Disease', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thymelaea hirsuta (L.) Endl'),MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Anabasis articulata (Forssk) Moq.'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Anchusa strigasa'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Anethum graveolens L.')])
MedicalActivity.create(
  name: 'עורון', 
  english_name: 'Blindness', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Paronychila argentea Lam.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.')] )
MedicalActivity.create(
  name: 'עיניים דלקת כאבים', 
  english_name: 'Inflammation Of The Eye', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb'), MedicinalHerb.find_by(latin_name: 'Anethum graveolens L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
MedicalActivity.create(
  name: 'מערכת העכול', 
  english_name: 'Digestive System', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')] )
MedicalActivity.create(
  name: 'עצירות', 
  english_name: 'Constipation', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Ceratonia siliqua L.'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'עקיצת דבורה', 
  english_name: 'עקיצת דבורה', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.')])
MedicalActivity.create(
  name: 'עקיצת עקרב', 
  english_name: 'Scorpion Bite', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb')] )
MedicalActivity.create(
  name: 'עקיצת צרעה', 
  english_name: 'Wa Sp Bite', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.')])
MedicalActivity.create(
  name: 'פצעים בפה ובלשון', 
  english_name: 'Aphtha', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Ceratonia siliqua L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.')])
MedicalActivity.create(
  name: 'פטריות', 
  english_name: 'Fungus', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa')])
MedicalActivity.create(
  name: 'פרקים (דלקת, התכווצויות, כאבים)', 
  english_name: 'Joint   Disorders', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Anabasis articulata (Forssk) Moq.'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Imperata cylindrica (L.) P. Beauv.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')] )
MedicalActivity.create(
  name: 'פרקינסון', 
  english_name: "Parkinson's Syndrome", 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')] )
MedicalActivity.create(
  name: 'צהבת', 
  english_name: 'Hepatitis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Imperata cylindrica (L.) P. Beauv.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')] )
MedicalActivity.create(
  name: 'צפדינה', 
  english_name: 'Scurvy', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz')] )
MedicalActivity.create(
  name: 'צרבת', 
  english_name: 'Heartburn', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')] )
MedicalActivity.create(
  name: 'צרעת', 
  english_name: 'Leprosy', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.')])
MedicalActivity.create(
  name: 'קדחת', 
  english_name: 'Malaria', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.')])
MedicalActivity.create(
  name: 'קיבה, תריסריון (דלקת, כיב,קילקול)', 
  english_name: 'Digestive System', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
MedicalActivity.create(
  name: 'דלקת קרום המוח', 
  english_name: 'Meningitis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')] )
MedicalActivity.create(
  name: 'דלקת ראות', 
  english_name: 'Pneumonia', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Paronychila argentea Lam.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Imperata cylindrica (L.) P. Beauv.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
MedicalActivity.create(
  name: 'כאב ראש', 
  english_name: 'Headache', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Portulaca oleracea L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Vitex agnus-castus L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'מיגרנה', 
  english_name: 'Migraine', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Anabasis articulata (Forssk) Moq.'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
MedicalActivity.create(
  name: 'כאבי רגלים', 
  english_name: 'Sore Feet', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Artiplex halimus L.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.')])
MedicalActivity.create(
  name: 'שגרון', 
  english_name: 'Rheumatism', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.')])
MedicalActivity.create(
  name: 'כאבים בשדיים', 
  english_name: 'Breast Pain', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
MedicalActivity.create(
  name: 'שחין', 
  english_name: 'Boils', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.')])
MedicalActivity.create(
  name: 'שלשול', 
  english_name: 'Diarrhea', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory'),MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Teucrium polium L.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Ceratonia siliqua L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'squiriting cucumber'), MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L."), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
MedicalActivity.create(
  name: 'כאבי שינים', 
  english_name: 'Sore Teeth', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Prosopis farcta (Banks et Sol) Macbride.'),MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Lycium earopaeum'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Sinapis alba L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb'), MedicinalHerb.find_by(latin_name: 'Herera helix L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
MedicalActivity.create(
  name: 'שפעת', 
  english_name: ' Influenza', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.')] )
MedicalActivity.create(
  name: 'שפשפת', 
  english_name: 'Jock Itch', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.')] )
MedicalActivity.create(
  name: 'דלקת שקדים', 
  english_name: 'Tonsillitis', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb')])
MedicalActivity.create(
  name: 'כאבי שרירים, התכווצויות שרירים', 
  english_name: 'Muscle Aches', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Cyperus rotundus L.'), MedicinalHerb.find_by(latin_name: 'Chrysanthemum coronarium L.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
MedicalActivity.create(
  name: 'שיתוק', 
  english_name: 'Paralysis', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.'), MedicinalHerb.find_by(latin_name: 'Ricinus communis L.'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb')] )
MedicalActivity.create(
  name: 'אבססים', 
  english_name: 'Abscess', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.')])
MedicalActivity.create(
  name: 'אבעבועות', 
  english_name: 'Vesicle', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
MedicalActivity.create(
  name: 'דלקת במערכת דרכי השתן', 
  english_name: 'Urinary System Infection', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'agrimonia eupatoria L'), MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Agropyrum Repens (L.) P.Beauv'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Paronychila argentea Lam.'), MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.'), MedicinalHerb.find_by(latin_name: 'Ammi majus L.'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Anabasis articulata (Forssk) Moq.'), MedicinalHerb.find_by(latin_name: 'Amaranthus retroflexus L.'), MedicinalHerb.find_by(latin_name: 'Apium graveolens L.'), MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.'), MedicinalHerb.find_by(latin_name: 'Laurus nobilis L.'), MedicinalHerb.find_by(latin_name: 'Satureja thymbra L.'), MedicinalHerb.find_by(latin_name: 'Portulaca oleracea L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.'), MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Bidens pilosa'), MedicinalHerb.find_by(latin_name: 'Imperata cylindrica (L.) P. Beauv.'), MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.')])
MedicalActivity.create(
  name: 'תבלול (קטרקט)', 
  english_name: 'Cataract', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Eryngium creticum Lam'), MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.')])

# Active Ingredient
ActiveIngredient.create(
  name: 'אבסינט', 
  english_name: 'Absinthe', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
ActiveIngredient.create(
  name: 'אדרנלין', 
  english_name: 'Adrenaline', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz')])
ActiveIngredient.create(
  name: 'אויקולרין', 
  english_name: 'Avicularin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.')])
ActiveIngredient.create(
  name: 'אוכסלט', 
  english_name: 'Oxalate', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb')])
ActiveIngredient.create(
  name: 'אולאורופאן (גליקוזיד)', 
  english_name: 'Glycoside', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Olea europae L.')])
ActiveIngredient.create(
  name: 'אולנדרין', 
  english_name: 'Oleandrin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Nerium oleander L.')])
ActiveIngredient.create(
  name: 'אטרופין', 
  english_name: 'Atropine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Datura stramonium L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
ActiveIngredient.create(
  name: "אימוג'ינין", 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.')])
ActiveIngredient.create(
  name: 'אינולין', 
  english_name: 'Inoline', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Agropyrum Repens (L.) P.Beauv'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.')])
ActiveIngredient.create(
  name: 'איצטמין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
ActiveIngredient.create(
  name: 'אכילאין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip')])
ActiveIngredient.create(
  name: 'אלטרין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'squiriting cucumber')])
ActiveIngredient.create(
  name: 'אלפא ביזבולול', 
  english_name: 'Alpha Bisabolol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip')] )
ActiveIngredient.create(
  name: 'אלקלואידים', 
  english_name: 'Alkaloids', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Daucus carota L.'), MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Datura stramonium L.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz'), MedicinalHerb.find_by(latin_name: 'Conium maculatum L.'), MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.'), MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
ActiveIngredient.create(
  name: 'אמפתמין', 
  english_name: 'Amphetamine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'אנול', 
  english_name: 'Enols', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'אנטול', 
  english_name: 'Antol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'אנטולקטון', 
  english_name: 'Antolactone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.')])
ActiveIngredient.create(
  name: 'אנטי תירוקסינית', 
  english_name: 'Anti Thyroxine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Sinapis alba L.')])
ActiveIngredient.create(
  name: 'אנטרקינונים', 
  english_name: 'Anthraquinone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.')])
ActiveIngredient.create(
  name: 'אנמונין', 
  english_name: 'Anemonin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Imperata cylindrica (L.) P. Beauv.')])
ActiveIngredient.create(
  name: 'אסטרוגנים', 
  english_name: 'Estrogens', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'אספירין', 
  english_name: 'Aspirin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.')])
ActiveIngredient.create(
  name: 'אספרלוסיד', 
  english_name: 'Asperuloside', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Galium aparine L.')])
ActiveIngredient.create(
  name: 'אסקרדיול', 
  english_name: 'Ascaridole', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Chenopodium ambrosioides L.')])
ActiveIngredient.create(
  name: 'אפיגנין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip')])
ActiveIngredient.create(
  name: 'אפיול', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Apium graveolens L.')])
ActiveIngredient.create(
  name: 'אפינפרין', 
  english_name: 'Epinephrine', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'אטציל-כולין', 
  english_name: 'Acetylcholine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Datura stramonium L.'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.')])
ActiveIngredient.create(
  name: 'אקבלין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'squiriting cucumber')])
ActiveIngredient.create(
  name: 'ארבינה', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk')])
ActiveIngredient.create(
  name: 'ארבינוז', 
  english_name: 'Arabinose', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk')])
ActiveIngredient.create(
  name: 'ארתמיזינין', 
  english_name: 'Artemisinin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
ActiveIngredient.create(
  name: 'אשלגן', 
  english_name: 'Potassium', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'ביתא ציסטוסטרול', 
  english_name: 'Beta Cistosterol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Portulaca oleracea L.')])
ActiveIngredient.create(
  name: 'גלאוצין', 
  english_name: 'Glaucine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz')])
ActiveIngredient.create(
  name: 'גליצרהיזין', 
  english_name: 'Glycyrrhizin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'גליקוזיד החצב', 
  english_name: 'Squill Glycosides', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.')])
ActiveIngredient.create(
  name: 'גליקוזידים', 
  english_name: 'Glycosides', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard'), MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth'), MedicinalHerb.find_by(latin_name: 'Galium aparine L.'), MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.'), MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.'), MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.'), MedicinalHerb.find_by(latin_name: 'Asphodelus microcarpus Slazm & Viv.')])
ActiveIngredient.create(
  name: 'גליקוזידים קרדיאליים', 
  english_name: 'Cardial Glycosides', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.')])
ActiveIngredient.create(
  name: "ג'קובין", 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.')])
ActiveIngredient.create(
  name: 'דאוצין', 
  english_name: 'Daucine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Daucus carota L.')])
ActiveIngredient.create(
  name: 'דופאמין', 
  english_name: 'Dopamine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: "דיאוסג'ינין", 
  english_name: 'Diosgenin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.')])
ActiveIngredient.create(
  name: 'דיגידוקסין', 
  english_name: 'Digitoxin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.')])
ActiveIngredient.create(
  name: 'דיגיטלין (גליקוזיד)', 
  english_name: 'Glycoside', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Nerium oleander L.')])
ActiveIngredient.create(
  name: 'היזרוקורטיזון', 
  english_name: 'Hydrocortisone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
ActiveIngredient.create(
  name: 'הידרוקרבונים', 
  english_name: 'Hydrocarbons', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.')])
ActiveIngredient.create(
  name: 'היסטמין', 
  english_name: 'Histamine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.')])
ActiveIngredient.create(
  name: 'הרמידין (אלקלואיד)', 
  english_name: 'Hermidine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')])
ActiveIngredient.create(
  name: 'הרמלין (אלקלואיד)', 
  english_name: 'Harmaline Alkaloids', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')])
ActiveIngredient.create(
  name: 'הרמין (אלקלואיד)', 
  english_name: 'Harmine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')])
ActiveIngredient.create(
  name: 'ויטאזומין', 
  english_name: 'Aaa', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.')])
ActiveIngredient.create(
  name: 'ויטאפרין', 
  english_name: 'Aaa', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Withania somnifera (L.) Dun.')])
ActiveIngredient.create(
  name: 'ויטמין A', 
  english_name: 'Vitamin A', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.')])
ActiveIngredient.create(
  name: 'ויטמין B', 
  english_name: 'Vitamin B', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rosa canina L.')])
ActiveIngredient.create(
  name: 'ויטמין C', 
  english_name: 'Vitamin C', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.'), MedicinalHerb.find_by(latin_name: 'Rosa canina L.'), MedicinalHerb.find_by(latin_name: 'Rumex cyprius Murb'), MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik')])
ActiveIngredient.create(
  name: 'ויטמין F', 
  english_name: 'Vitamin F', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik')])
ActiveIngredient.create(
  name: 'ויסנגין', 
  english_name: 'Visnagin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ammi majus L.')])
ActiveIngredient.create(
  name: 'ורבלין (גליקוזיד)', 
  english_name: 'Verbalin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.')])
ActiveIngredient.create(
  name: 'ורבנין (גליקוזיד)', 
  english_name: 'Verbenin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Verbena officinalis L.')])
ActiveIngredient.create(
  name: 'זיזיפין (אלקלואיד)', 
  english_name: 'Ziziphine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ziziphos spina-christi (L.) Desf')])
ActiveIngredient.create(
  name: 'חמזולן', 
  english_name: 'Chamazulene', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip')])
ActiveIngredient.create(
  name: 'חומצה אלפא-לינולנית', 
  english_name: 'Alpha Linolenic Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Portulaca oleracea L.')])
ActiveIngredient.create(
  name: 'חומצה גליצרטית', 
  english_name: 'Glycyrrhetic Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'חומצה גלית', 
  english_name: ' Gallic Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb')])
ActiveIngredient.create(
  name: 'חומצה מרובית', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.')])
ActiveIngredient.create(
  name: 'חומצה סליצילית', 
  english_name: 'Salicylic Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.')])
ActiveIngredient.create(
  name: 'חומצה פומרית', 
  english_name: 'Fumaric Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Capsella bursa-pastoris (L.) Medik')])
ActiveIngredient.create(
  name: 'חומצה שומנית', 
  english_name: 'Fatty Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: "butcher's aculeatus L.")])
ActiveIngredient.create(
  name: 'חומצת נמלים', 
  english_name: 'Formic Acid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.')])
ActiveIngredient.create(
  name: 'חנקן', 
  english_name: 'Nitrogen', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Peganum harmala L.')])
ActiveIngredient.create(
  name: 'טויון', 
  english_name: 'Thujone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.')])
ActiveIngredient.create(
  name: 'טנינים', 
  english_name: 'Tannins', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Quercus calliprinos Webb'), MedicinalHerb.find_by(latin_name: 'Polygonum arenastrum Bor.'), MedicinalHerb.find_by(latin_name: 'Malva nicaeensis All.')])
ActiveIngredient.create(
  name: 'טסטוסטרון', 
  english_name: 'Testosterone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
ActiveIngredient.create(
  name: 'טרגון', 
  english_name: 'Tarragon', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
ActiveIngredient.create(
  name: 'טרופניים', 
  english_name: 'Tropane', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Datura stramonium L.')])
ActiveIngredient.create(
  name: 'טריגונולין (אלקלואיד)', 
  english_name: 'Trigonelline', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.')])
ActiveIngredient.create(
  name: 'טריטיצין (פחמן)', 
  english_name: 'Triticin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Agropyrum Repens (L.) P.Beauv')])
ActiveIngredient.create(
  name: 'טרפנטין', 
  english_name: 'Turpentine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Pistacia lentiscus L.')])
ActiveIngredient.create(
  name: 'יוד', 
  english_name: 'Iodine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.')])
ActiveIngredient.create(
  name: 'יוני נתרן', 
  english_name: 'Sodium Ions', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'יוסציאמין (אלקלואיד)', 
  english_name: 'Hyoscyamine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Datura stramonium L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
ActiveIngredient.create(
  name: 'יוסצין (אלקלואיד)', 
  english_name: 'Hyoscine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.')])
ActiveIngredient.create(
  name: 'כהל', 
  english_name: 'Alcohol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.'), MedicinalHerb.find_by(latin_name: 'Calotropis procera (Ait.) Ait F.'), MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.')])
ActiveIngredient.create(
  name: 'כולסטרול', 
  english_name: 'Cholesterol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Olea europae L.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk'), MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'כמון', 
  english_name: 'Cumin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Quercus ithaburensis'), MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.')])
ActiveIngredient.create(
  name: 'ליגנינים', 
  english_name: 'Lignen', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.')])
ActiveIngredient.create(
  name: 'לגנול', 
  english_name: 'Lignol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth')])
ActiveIngredient.create(
  name: 'לימונן', 
  english_name: 'Lignol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Apium graveolens L.')])
ActiveIngredient.create(
  name: 'לינלול', 
  english_name: 'Linalool', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Coriandrum sativum L.')])
ActiveIngredient.create(
  name: 'ליפזה (אנזים)', 
  english_name: 'Lipase', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ricinus communis L.')])
ActiveIngredient.create(
  name: 'לקטונים-ססקויטרפנים', 
  english_name: 'Lactone Sesquiterpene', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Myrtus commuins L.'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.')])
ActiveIngredient.create(
  name: 'מוצילגים', 
  english_name: 'Mucilage', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Verbascum eremobium Murb.'), MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk')])
ActiveIngredient.create(
  name: 'מטמוסיל', 
  english_name: 'Metamucil', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk')])
ActiveIngredient.create(
  name: 'מירוזין (אנזים)', 
  english_name: 'Myrosinase', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Sinapis alba L.')])
ActiveIngredient.create(
  name: 'מנתול', 
  english_name: 'Menthol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.')])
ActiveIngredient.create(
  name: 'מסקלין', 
  english_name: 'Mescaline', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'מסקילוז (רב סוכרים)', 
  english_name: 'Maxillus', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.')])
ActiveIngredient.create(
  name: 'מרובין', 
  english_name: 'Marrubiin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Marrubium vulgare L.')])
ActiveIngredient.create(
  name: 'נוראפינפרין', 
  english_name: 'Norepinephrine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'נרידורין', 
  english_name: 'Neridorine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Nerium oleander L.')])
ActiveIngredient.create(
  name: 'נרין', 
  english_name: 'Nerin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Nerium oleander L.')])
ActiveIngredient.create(
  name: 'סודיום כרומוגליט ', 
  english_name: 'Sodium Cromoglycate', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ammi majus L.')])
ActiveIngredient.create(
  name: 'סוכרוז', 
  english_name: 'Sucrose', 
  medicinal_herbs:[MedicinalHerb.find_by(latin_name: 'Alhagi maurorum Melik'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')] )
ActiveIngredient.create(
  name: 'סולנידין (גליקוזיד)', 
  english_name: 'Solanidine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
ActiveIngredient.create(
  name: 'סולנין (גליקוזיד)', 
  english_name: 'Solanine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
ActiveIngredient.create(
  name: 'סולסודין', 
  english_name: 'Solasodine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
ActiveIngredient.create(
  name: 'סטכילונה', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.')])
ActiveIngredient.create(
  name: 'סטכילרין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Capparis spinosa L.')])
ActiveIngredient.create(
  name: 'סטרואידים', 
  english_name: 'Steroid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Trigonella foenum-graceum L.'), MedicinalHerb.find_by(latin_name: 'Balanites aegyptiaca (L.) Del.'), MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'), MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'סטרולים', 
  english_name: 'Sterols', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso'), MedicinalHerb.find_by(latin_name: "butcher's aculeatus L.")])
ActiveIngredient.create(
  name: 'סטריכנין', 
  english_name: 'Strychnine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Conium maculatum L.')])
ActiveIngredient.create(
  name: 'סיבין', 
  english_name: ' Sivin ', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk')])
ActiveIngredient.create(
  name: 'סיליבין', 
  english_name: 'Silibinin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth')])
ActiveIngredient.create(
  name: 'סילידיאנין', 
  english_name: 'Silydianin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth')])
ActiveIngredient.create(
  name: 'סילימרין', 
  english_name: 'Silymarin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth')])
ActiveIngredient.create(
  name: 'סיליקריסטין', 
  english_name: 'Silychristin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Silybum marianum (L.) Gaerth')])
ActiveIngredient.create(
  name: "סינוסיד א' ,ב'", 
  english_name: 'Sinosid', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.')])
ActiveIngredient.create(
  name: 'סיניגרין', 
  english_name: 'Sinigrin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Sinapis alba L.')])
ActiveIngredient.create(
  name: 'סינפיטון', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Varthemia iphionoides. Boiss et Bl.'), MedicinalHerb.find_by(latin_name: 'Althea officinalis L.')])
ActiveIngredient.create(
  name: 'סליסט', 
  english_name: 'Salist ', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.')])
ActiveIngredient.create(
  name: 'סליצין', 
  english_name: 'Salicin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Salix alba L.')])
ActiveIngredient.create(
  name: 'סנטונין', 
  english_name: 'Santonin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
ActiveIngredient.create(
  name: 'סניוצין', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.')])
ActiveIngredient.create(
  name: 'סנצין (אלקלואיד)', 
  english_name: 'Cancine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Senecio vugaris L.')])
ActiveIngredient.create(
  name: 'ספונינים', 
  english_name: 'Saponins', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.')])
ActiveIngredient.create(
  name: 'ספרטאין (אלקלואיד)', 
  english_name: 'Sparteine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb')])
ActiveIngredient.create(
  name: 'סקופולמין (אלקלואיד)', 
  english_name: 'Scopolamine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mandragora autumnalis Bertol.'), MedicinalHerb.find_by(latin_name: 'Datura stramonium L.'), MedicinalHerb.find_by(latin_name: 'Hyoscyamus aureus L.')])
ActiveIngredient.create(
  name: 'סרוטונין', 
  english_name: 'Serotonin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.')])
ActiveIngredient.create(
  name: 'פולגון', 
  english_name: 'Pulegone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Thyme-Leaved Savory')])
ActiveIngredient.create(
  name: 'פורנוקומרינים', 
  english_name: 'Furnocoumarins', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.')])
ActiveIngredient.create(
  name: 'פחמימן', 
  english_name: 'Hydrocarbon', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Agropyrum Repens (L.) P.Beauv')])
ActiveIngredient.create(
  name: 'פטאילידים', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Apium graveolens L.')])
ActiveIngredient.create(
  name: 'פלבון', 
  english_name: 'Flavones', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rhus coriaria L.')])
ActiveIngredient.create(
  name: 'פלבונואידים', 
  english_name: 'Plavonoids', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Matricaria aurea (Loefi.) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Inula viscosa (L.) Ait.'), MedicinalHerb.find_by(latin_name: 'Crataegus aronia (L.) Bosc. ex. DC.')])
ActiveIngredient.create(
  name: 'פנול', 
  english_name: 'Phenol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Salvia fruticosa Mill.'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb')])
ActiveIngredient.create(
  name: 'פניל פטטרין', 
  english_name: 'Phenyl', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Bidens pilosa')])
ActiveIngredient.create(
  name: 'פעילות אסטרוגנית', 
  english_name: 'Astrogenit Activity', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.'), MedicinalHerb.find_by(latin_name: 'Foeniculum vulgare Mill.')])
ActiveIngredient.create(
  name: 'פעילות ציטוטוקסית', 
  english_name: 'Cytotoxic Activity', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.')])
ActiveIngredient.create(
  name: 'פקטינים', 
  english_name: 'Pectin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Rosa canina L.')])
ActiveIngredient.create(
  name: 'פרוגסטרון', 
  english_name: 'Progesterone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.')])
ActiveIngredient.create(
  name: 'פרוסטגלנדינים', 
  english_name: 'Prostaglandins', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Cassia italica (Mill) Lam.'), MedicinalHerb.find_by(latin_name: 'Salix alba L.')])
ActiveIngredient.create(
  name: 'פרוציליארן', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.')])
ActiveIngredient.create(
  name: 'פרוצילרידין A', 
  english_name: 'Procyclidine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Urginea maritima (L.) Bak.')])
ActiveIngredient.create(
  name: 'צורן', 
  english_name: 'Silicon', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Uritca pilulifera L.')])
ActiveIngredient.create(
  name: 'ציטרונל', 
  english_name: 'Citronella', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.')])
ActiveIngredient.create(
  name: 'ציטרל', 
  english_name: 'Citral', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Melissa officinalis L.')])
ActiveIngredient.create(
  name: 'ציקלמין (ספונון)', 
  english_name: 'Cyclamen', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Cyclamen persicum Mill.')])
ActiveIngredient.create(
  name: 'צפרן', 
  english_name: 'Aaa', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Achillea fragrantissima (Forrsk) Sch. Bip'), MedicinalHerb.find_by(latin_name: 'Sarcopoterium spinosum (L.) Sp.')])
ActiveIngredient.create(
  name: 'קהלין', 
  english_name: 'Khelline', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ammi majus L.')])
ActiveIngredient.create(
  name: 'קהלול', 
  english_name: 'Khella', 
  medicinal_herbs:  [MedicinalHerb.find_by(latin_name: 'Ammi majus L.')])
ActiveIngredient.create(
  name: 'קודאין', 
  english_name: 'Codeine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glaucium flavum Crantz')])
ActiveIngredient.create(
  name: 'קולוצינטין (גליקוזיד)', 
  english_name: 'Colocynthin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'citrullus colocynthis (L) shard')])
ActiveIngredient.create(
  name: 'קולפרמין', 
  english_name: 'Colpermin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.')])
ActiveIngredient.create(
  name: 'קומרין (אלקלואיד)', 
  english_name: 'Coumarin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.'), MedicinalHerb.find_by(latin_name: 'Haplophyllum tuberculatum (Forssek) Ad. juss.')])
ActiveIngredient.create(
  name: 'קונאין (אלקלואיד)', 
  english_name: 'Coniine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Conium maculatum L.')])
ActiveIngredient.create(
  name: 'קוקורביטצינים', 
  english_name: 'Cucurbitacins', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'squiriting cucumber')])
ActiveIngredient.create(
  name: 'ריצין', 
  english_name: 'Ricin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ricinus communis L.')])
ActiveIngredient.create(
  name: 'קורטיזון', 
  english_name: 'Cortisone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Solanum nigrum L.'),MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'קמפור', 
  english_name: 'Camphor', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif')])
ActiveIngredient.create(
  name: 'קסילוז', 
  english_name: 'Xylose', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Plantago ovata Forssk')])
ActiveIngredient.create(
  name: 'קפילין', 
  english_name: 'cofilin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Artemisia herba-alba Asso')])
ActiveIngredient.create(
  name: 'קרבון', 
  english_name: 'carbon', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.'),MedicinalHerb.find_by(latin_name: 'Anethum graveolens L.')])
ActiveIngredient.create(
  name: 'קרבין', 
  english_name: 'Carbyne', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Nerium oleander L.')])
ActiveIngredient.create(
  name: 'קרבנוקסולון', 
  english_name: 'Carbenoxolone', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'קרבקרול', 
  english_name: 'Carvacrol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb')])
ActiveIngredient.create(
  name: 'רואחול', 
  english_name: 'rowachol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Mentha pulegium L.')])
ActiveIngredient.create(
  name: 'רוטין', 
  english_name: 'Rutin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.')])
ActiveIngredient.create(
  name: 'רוטמרין', 
  english_name: 'rutamarin', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Ruta chalepensis L.')])
ActiveIngredient.create(
  name: 'רתאמין', 
  english_name: 'Retamine', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Retama raetam (Forssk.) Webb')])
ActiveIngredient.create(
  name: 'שושאון', 
  english_name: 'Shushon', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Glycyrrhiza glabra L.')])
ActiveIngredient.create(
  name: 'תימול', 
  english_name: 'Thymol', 
  medicinal_herbs: [MedicinalHerb.find_by(latin_name: 'Majorana Syriaca (L.) Raif'), MedicinalHerb.find_by(latin_name: 'Coridothymus capitatus (L.) Reichb')])

# Crystals

Crystal.create(name: 'אבלון',
  english_name: 'Avalone Paua Shell',
  hardness: '',
  chemical_formula: 'סידן',
  qualities: 'מחזק עצמות משפר זרימת דם ללב, מרענן את הגוף בזמן ירידה אנרגטית, יעניק שמחה בהשמתו במקלחת',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת - אש',
  english_name: 'Aaa',
  hardness: '',
  chemical_formula: 'SiO2',
  qualities: 'תעזור להוציא את המקסימום מהאוחז בא, תעניק שמחה, עוזרת בטיפול בזרימת הדם ובעיות בעיניים.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת בוצואנה',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'Sio2',
  qualities: 'עוזרת בהתמודדות עם הבלתי נודע, עוזרת ליצירתיות והעבאת רגשות, תוענת את האור המקיף, עוזרת לטיפול במערכת העצבים, ',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת בלו',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'עוזרת בהשגת שלווה וגילוי השלווה הפנימית, טובה למתקשים בדיבור, מעצימה את החושים, עוזרת לטיפול בבלוטת התריס.',
  use_instructions: "אחיזה או נשיאה בתכשיט על הצ'אקרה החמישית ",
  warnings: '')
Crystal.create(name: "אגת ג'אוד",
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'Sio2',
  qualities: 'טובה לאנליסטים, מחזקת קיימות ועוזרת בראיית העתיד, עוזרת בטיפול בעיות בידיים ובריאות',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת דנדרייט',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'מעדנת ומאירה באור יפה את החיים, עוזרת בריכוז במבחנים, עוזרת בהבנת מספר אירועים בו זמנית,יוצרת הרמוניה עם הטבע, מסייעת בטיפול במערכת העצבים.\r\nמוקרת במקורות כאבן הסנא.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת טורטלה',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'נותנת רוח יתרה להתמודדות עם מצבים הזקוקים לפיתרון, עוזרת לתקשר עם צמחים ומינרליים, טובה לטיפול בכאבי בטן., ',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת מוס כתום',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'טובה לעייפות כרונית, עוזרת לטיפול באיזור הבטן, מחזקת את התוספתן.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת עין',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'נותנת אור ותקווה במצבי יאוש.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אגת עץ',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'נותנת אפשרות לראות את הטבע כמו שהוא, עוזרת מאוד בנפילה במערכת החיסון, במצבים של בלבול תאזן, עוזרת בטיפול במעטפת הלב.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אדמית',
  english_name: 'Aaa',
  hardness: '3-4',
  chemical_formula: 'nz2 (AsO4) (OH)',
  qualities: 'אבן נדירה ביותר, עוזרת לאזן בין השכל לרגשות ומעצימה אותם תוך כדי, עוזרת במקרים של חשיבה מקובעת וכך עוזרת בתחומים עסקיים, שייכת למשפחה המטפלת בלב ובריאות ובהרבה מקרים עוזרת לצרידות הקול (טובה לזמרים ולתלמידי פיתוח קול).',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אובסידיאן ריינבו',
  english_name: 'Aaa',
  hardness: '5-6',
  chemical_formula: 'זכוכית געשית',
  qualities: 'אבן הידועה משחר הימים כמעניקה שמחה.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אובסידיאן שחור',
  english_name: 'Aaa',
  hardness: '5-6',
  chemical_formula: 'זכוכית געשית הנוצרת באופן טבעי',
  qualities: "מגינה מאנרגיות שליליות, נותנת אפשרות להגיע לתשובה נכונה ע\"י שעוזרת למקד את הראייה הפנימית בכל דבר ודבר, עובדת על צ'קראת הבסיס. טובה לטיפול במעיים ובשרירי הגוף.",
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אוונטורין',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SiO2',
  qualities: 'מרגיעה את הלב, עוזרת בקבלת עצמאות, אם תשולב עם רוז קוורץ תעזור במקרים של הקרנות (סרטן) טובה לטיפול בשרירי הגוף.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם (אופל)',
  english_name: 'Aaa',
  hardness: '',
  chemical_formula: 'SiO2NH2O',
  qualities: "תעזור להגביר את המודעות כלפי הרגשות, ולהבין את האינטואיציה הפנימית, פותחת את הצ'אקרה החמישית.\r\nמופיע במקורות כאחת מאבני החושן.",
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: 'אסורה בשימוש לאנשים הססנים')
Crystal.create(name: 'אגת - שבו',
  english_name: 'Agate',
  hardness: '6.5-7',
  chemical_formula: 'SiO2',
  qualities: 'האגת טובה לאיזון האינטואיציה אל מול הלוגיקה, מעניקה תכושת חיוניות לגוף ולמוח (ראה קבוצת האגת).\r\nמופיע במקורות כאחד מאבי החושן.',
  use_instructions: 'אחיזה או בתכשיט',
  warnings: '')
Crystal.create(name: 'שוהם (אונגס)',
  english_name: 'Aaa',
  hardness: '3',
  chemical_formula: 'CaCO3',
  qualities: 'עוזרת במצבי דיכאון שימשה בימי קדם לאזן קוטביות, טובה לנשים בגיל המעבר, עוזרת בטיפול במח עצם חלש.\r\nמופיע במקורותינו כאחת מאבני החושן.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם אש',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O',
  qualities: 'לשם אש מעניקה אנרגיה ואור בקצה המנהרה.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם כחול',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O ',
  qualities: 'עוזרת לתקשורת בין אנשים, אבן חיובית המעודדת חיוביות.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם לבן',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O ',
  qualities: 'עוזרת לסדר את החיים ובמצבי בלבול מחברת את בעליית לעשירות.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם מטריקס',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O ',
  qualities: 'כמו בלשם הכחול.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם עין החתול',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O ',
  qualities: 'כמו האופל הלבן.\r\nבנוסף מעודדת יצירתיות.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם קומון',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O ',
  qualities: 'תכונות כמו הלשם הלבן.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'לשם שחור',
  english_name: 'Aaa',
  hardness: '5.4-6.4',
  chemical_formula: 'SiO2NH2O ',
  qualities: 'עוזרת לאהוב את עצמך, מבטלת מצבי לחץ, מטפלת בבעיות אזניים הגורמות לחוסר שיווי משקל.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אוקנייט',
  english_name: 'Aaa',
  hardness: '5-5.5',
  chemical_formula: 'Ca5Si9023.9H2O',
  qualities: 'אבן ידידותית העוזרת להתחבר לנקודת הילד.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'ספיר ים (קורדוררייט)',
  english_name: 'Aaa',
  hardness: '7-7.5',
  chemical_formula: 'Mg2Ai3(AISA5O18)',
  qualities: 'האיולייט מוכרת במקורות כספיר ים או כקורדורייט, עובדת חזק על איזור הגרון והראש, מעלימה כאבי ראש במגע בלבד וידועה בסיועה לכבד בהרחקת רעלים מהגוף. יש סגולה האומרת שספיר הים יכול לפקח שיכורים.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אזורייט',
  english_name: 'Aaa',
  hardness: '3.5-4',
  chemical_formula: 'Cu3(OH)2(CO3)2',
  qualities: 'אבן המייחדת את המיוחדים ומכשירה את המוכשרים ותעזור בכל ריפוי אשר האני הפנימי משתתף בו.\r\nעל פי המקורות השמת אבן זו בסמוך לראש בזמן השינה תעזור בזכירת חלומות.\r\nטובה לטיפול בתאי גוף פגומים. אין לנקות אבן זו במטלית לחה וטיהורה של אבן זו יהייה בשמש בלבד.\r\nמכפילה את כוחה בשילוב עם מלכית.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: 'אין לשתות מיים בהם הייתה אבן זו.')
Crystal.create(name: 'איוקלייס',
  english_name: 'Aaa',
  hardness: '7.5',
  chemical_formula: 'BeALSiO4(OH)',
  qualities: 'מחזקת שמחת חיים ומעודדת הגשמת העצמי, טובה מאוד ליחסים בין אישיים ותומכת במח השמאלי, תעזור לטיפול בדלקת פרקים וליחוי מהיר של חתכים.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אלבסטר',
  english_name: 'Aa',
  hardness: '2',
  chemical_formula: 'CaSO4.2H2O',
  qualities: 'אבן טובה לרגרסיה ולשיפור המדיטציה, עוזרת לביטחון העצמי וקבוצה אשר תחזיק כולה באבן זו, איש לעצמו שזכה ליחסים הרמוניים.\r\nטוב לשים אבן זו על הדלפק בבנק בזמן קבלת הטיפול בבעיות לב ועניים.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אלכסנדרייט',
  english_name: 'Aaa',
  hardness: '8.5',
  chemical_formula: 'AL2(BeO4)',
  qualities: 'אבן יקרה מאוד , עוזרת מאוד ביציאה מהגוף לצורך מסעות אטסרליים, יש לה תכונה למזג שלוש מרכזי אנרגיה של העין השלישית הבסיס והלב. יכולה לעכל על הסובלים מסרטן הדם.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: 'ש להזהר מאבנים מזוייפות.')
Crystal.create(name: 'אלמנדין',
  english_name: 'Aaa',
  hardness: '7.5',
  chemical_formula: 'Fe3LL2(SIO4)3',
  qualities: 'תעזור להיות בקשר עם האני הגבוה, עוזרת לטיפול בבעיות בכבד ובלבלב, ידועה בהקלתה על כאבים בגב העליון ובכתפיים.',
  use_instructions: 'נשיאת תכשיט או הדבקת אבן קטנה במקום הכואב',
  warnings: '')
Crystal.create(name: 'עינבר (אמבר)',
  english_name: 'Aaa',
  hardness: '2-2.5',
  chemical_formula: 'C10H10O',
  qualities: 'מחזקת את הזכרון, תעזור בהתחברות אל הטבע, משפרת את איכות הדם.\r\nשימשה בעבר הרחוק ככטורת.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אמולייט',
  english_name: 'Aaa',
  hardness: '2-3',
  chemical_formula: 'כלצית עם רסס אורגני',
  qualities: 'טובה לעוסקים בבניה, טובה לטיפול בדיכאון, תעזור ליולדת בזמן לידתה.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אמזנייט',
  english_name: 'Aaa',
  hardness: '6-6.5',
  chemical_formula: 'K(ALSI3O8)',
  qualities: 'אבן זו שמשה מאז ומעולם להרגיע ולהקל על מצבים נפשיים, נחשבת כמעודדת צמיחה רוחנית ועוזרת להפגין רגשות חיוביים.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אמטרין',
  english_name: 'Aaa',
  hardness: '7',
  chemical_formula: 'SIO2',
  qualities: 'אבן המשלבת בתוכה את האמטיסט בתוספת סיטרין, שתי אבנים אלו כאשר משולבות ביחד מעצימות זו את זו ומגבירות את המודעות הרוחנית. אבן זו ידועה בניקוי שליליות מהאור המקיף. טובה לנשים בגיל המעבר.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'ברקת (אמרלט, אימרגט)',
  english_name: 'Aaa',
  hardness: '7.5-8',
  chemical_formula: 'AL2Be3',
  qualities: 'אבן שתעזור במניעת אפילפסיה, מחזקת זיכרון, טובה לאנשים רואי שחורות ותגביר את כושר הדיבור בפני קהל.\r\nאבן זו מופיעה כחלק מאבני החושן של הכהן הגדול.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אחלמה (אמטיסט)',
  english_name: 'Aaa',
  hardness: '7-7.5',
  chemical_formula: 'SiO2',
  qualities: 'האבן ידועה בעזרה למתמכרים מכל סוג שהוא, פותחת את העין השלישית ועוזרת להבין בעיני הרוח את המציאות הגשמית. טובה לאנשים אגוצנטריים ונותנת אומץ למפחדים, מטפלת בכאבי ראש כרוניים ולא באלה הנגרמים מחוסר נוזלים.\r\nאבן זו מופיעה כחלק מאבני החושן של הכהן הגדול.',
  use_instructions: 'לכאבי ראש יש להניח את האבן במרכז המצח ולהוציאה כשהכאב נעלם. לא ידועות תופעות לוואי לטיפול זה.',
  warnings: '')
Crystal.create(name: "אנג'לייט",
  english_name: 'Aaa',
  hardness: '3.5',
  chemical_formula: 'CaSO4',
  qualities: 'אבן זו תעזור מאוד לטלפתיה ותעזור לאזן גוף פיזי ורגשי.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אנדלוסייט',
  english_name: ' Aaa',
  hardness: '7.5',
  chemical_formula: 'AL(ALSIO5)',
  qualities: 'נחשבת לאבן המביאה מזל טוב, מחזקת זיכרון ותעזור להתמקד בהשגת מתרות. טובה לטיפול בבעיות באזור האבן התחתונה.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אנדרדייט',
  english_name: 'Aaa',
  hardness: '6-7.5',
  chemical_formula: 'Sa3AL2(SIO4)3',
  qualities: 'אבן זו ידועה בתכונתה לחזק זוגיות, מגבירה אנדרנלין, טובה לגברים עם דימוי גברי נמוך, טובה לטיפול באזור הבטן.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אסטרופילייט',
  english_name: 'Aaa',
  hardness: '3-4',
  chemical_formula: '3(Fe,Mn)7(Ti,Zr)2(K,Na)',
  qualities: 'מומלצת למסעות מחוץ לגוף וידועה בהעלאת ההארכה העצמית, תעזור בהרחקת שומנים מהגוף.',
  use_instructions: 'נשיאה או תכשיט',
  warnings: 'אין לשתות מייה בהם הונחה אבן זו.')
Crystal.create(name: 'אפופילייט',
  english_name: 'Aaa',
  hardness: '5-6',
  chemical_formula: 'KCa4(Si8)O20(OH,F)8H2O',
  qualities: 'עוזרת בקשר לממדים גבוהים, בנשיאתה תבוא ההבנה שמצב של שלמות הוא המצב הטבעי. מקשרת את הנשמה לגוף בזמן יציאה מהגוף ותעזור לזכור את אשר נלמד במשא הזה.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אפטייט',
  english_name: 'Aaa',
  hardness: '5',
  chemical_formula: 'Sa5(F,CL,OH)(PO4)3)',
  qualities: 'תעזור במצבי לחץ בחיים טובה ללימוד, עוזרת לאיזון הבלוטות, מדחיקה תכושת רעב ובכך תעזור להרזייה.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אפידוט',
  english_name: 'Aaa',
  hardness: '',
  chemical_formula: 'Ca2(AL,Fe)3(Si2O7)(SIO4)O(OH)',
  qualities: 'טובה מאוד ללב ותעזור לריפוי ע\"י הקניית איזון.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')
Crystal.create(name: 'אקווה אורה (קוורץ)',
  english_name: 'Aaa',
  hardness: '7-7.5',
  chemical_formula: 'SiO',
  qualities: 'תעזור בניקוי ההילה מאנרגיות שליליות.',
  use_instructions: 'בנשיאה, בתכשיט או בשתיית מיים טהורים בהם הושרה הקריסטל',
  warnings: '')

Jewelry.create(name: 'שרשרת לריפוי כללי', english_name: 'necless', long_description: 'התערוכה החדשה הינה בבחינת הצדעה של ענף היהלומים הישראלי לתכשיט העברי הקדום בארץ ישראל,  במיוחד לרגל חגיגות השישים למדינת ישראל. מטרתה של תערוכת "תַּפּוּחֵי זָהָב בְּמַשְׂכִּיּוֹת כָּסֶף" היא למשוך  חוטים עלומים אל עברה של ארץ ישראל ולפתוח צוהר, באמצעות רבדי השפה העברית שנותרו בידינו, לעולמם של תושבי הארץ באמצעות תכשיטים אשר נמצאו בחפירות הארכיאולוגיות שנערכו ברחבי ארץ ישראל.',price: 300, image: open("public/images/jewelry-imgs/jewelry.jpg"))


JewelryCrystal.create(jewelry: Jewelry.find(1) ,crystal: Crystal.find_by(name: 'אבלון'), price: 90)

EssentialOil.create(name: 'רוזמרין', english_name: 'rosemary',use_instructions: 'מחזק שורשי שיער, דוחה כינים, עוזר לבהירות מחשבה ומחזק זיכרון.', warnings: 'אסור בהריון, לבעלי לחץ דם גבוה ולחולי אפילפסיה.', price_5ml: 23, price_10ml: 40, price_50ml: 100,image: open("public/images/essential-oil-imgs/oil.jpg"))


EssentialOil.create(name: 'רוזמרין', english_name: 'rosemary')
