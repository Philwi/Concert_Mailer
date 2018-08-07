COPY bookers(stadt,club,name,homepage,email,telefon,bundesland,land) FROM '/home/phil/Concert_Mailer/Bookinglist/Booking-Spreadsheet.csv' DELIMITER ',' CSV HEADER;

//delete duplicates:
DELETE FROM bookers t1
USING bookers t2
WHERE t1.club = t2.club
AND t1.name = t2.name
AND t1.stadt = t2.stadt
AND t1.id > t2.id;
