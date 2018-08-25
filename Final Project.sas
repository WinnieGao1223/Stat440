title '440 Final Project Report';
option nodate pageno=1 center ls=96;
libname project 'C:\440\project';

/*Import the dataset named ign*/
filename Game '/home/zgao220/440/Final Project/ign.csv';

proc import datafile=Game dbms=csv out=project_game (drop=url platform release_month release_day)replace; 
	getnames=yes;
run;

proc contents data=project_game;
	title 'Descriptor Portion of Game';
run;


/*Import the dataset named vgsales*/
filename vg '/home/zgao220/440/Final Project/vgsales.csv';

proc import datafile=vg dbms=csv out=project_vsales (drop=rank platform publisher other_sales) replace;
	getnames=yes;
run;

proc contents data=project_vsales;
	title 'Descriptor Portion of videogame sales';
run;

/*Import the dataset named movie_metadata.csv*/
filename meta '/home/zgao220/440/Final Project/movie_metadata.csv';

proc import datafile=meta dbms=csv out=project_movie(drop=color director_name duration actor_2_name gross actor_1_name num_voted_users actor_3_name facenumber_in_poster plot_keywords movie_imdb_link num_user_for_reviews language content_rating budget  aspect_ratio) replace;
	getnames=yes;
run;

proc contents data=project_movie;
	title 'Descriptor Portion of movie';
run;

/*Check the frequency of Three Datasets*/
proc freq data=project_game;
	title 'Table for frequence of genre for game';
	tables genre;
run;
/*There are 36 missing observations for the dataset named project_game.*/

proc univariate data=project_game;
	title 'Univariate table for game';
	var score;
	ods select extremeobs;
run;

proc freq data=project_vsales;
	title 'Table for frequence of genre for videogame sales';
	tables genre;
run;

proc univariate data=project_vsales;
	title 'Univariate table for videogame sales';
	ods select extremeobs;
run;

proc freq data=project_movie;
	title 'Table for frequence of genre for movie';
	tables genres;
run;

proc univariate data=project_movie;
	title 'Univariate Table for movie';
	var imdb_score;
	ods select extremeobs;
run;

/*Clean the data and try to summarize the genre as 7 categories*/
data game1;
	set project_game;
	keep genre score;
	if title='Meow Meow Happy Fight' then genre = 'Shooter';
	if title='War of the Vikings' then genre='Action';
	if title='Liqua Pop' then genre='Other';
	if title='Naruto Shippuden: Kizuna Drive' then genre='Action';
	if title='Aya and the Cubes of Light' then genre='Puzzle';
	if title='Stenches: A Zombie Tale of Trenches' then genre='Strategy';
	if title='Impossible Road' then genre='Racing';
	if title='Land-a Panda' then genre='Puzzle';
	if title='Boom Beach' then genre='Strategy';
	if title='Crystal Caverns of Amon-Ra' then genre='Puzzle';
	if title='Nintendogs + Cats: Toy Poodle & New Friends' then genre='Simulation';
	if title='Nintendogs + Cats: Golden Retriever & New Friends' then genre='Simulation';
	if title='Nintendogs + Cats: French Bulldog & New Friends' then genre='Simulation';
	if title='Heavy Mach' then genre='Battle';
	if title="Eyegore's Eye Blast" then genre='Action';
	if title='Nancy Drew: The Haunting of Castle Malloy' then genre='Adventure';
	if title='Tower Toppler' then genre='Platform';
	if title='Jeep Thrills' then genre='Racing';
	if title='The Hero' then genre='RPG';
	if title='21 Pro Blackjack' then genre='Strategy';
	if title='ShadowPlay' then genre='RPG';
	if title='Clue / Mouse Trap / Perfection / Aggravation' then genre='Other';
	if title='Golden Skull' then genre='Action';
	if title='Primrose' then genre='Puzzle';
	if title='AquaSpace' then genre='Simulation';
	if title='Aha! I Got It! Escape Game' then genre='Adventure';
	if title='The Horrible Vikings' then genre='Platform';
	if title='PopStar Guitar' then genre='Music';
	if title='Critter Crunch' then genre='Puzzle';
	if title='Rengoku' then genre='RPG';
	if title='Duke Nukem Arena' then genre='Shooter';
	if title='Super Sketcher' then genre='Action';
	if title='Wild Blood' then genre='Action';
	if title='Retro/Grade' then genre='Music';
	if title='Colour Bind' then genre='Platform';
	if title='10000000' then genre='RPG';
	
	if genre =: 'Action' then genre='Action';
	if genre =: 'Hunting' then genre='Action';
	if genre =: 'Other, Action' then genre='Action';
	if genre =: 'Fighting' then genre='Action';
	if genre=:'Racing' then genre='Action';
	if genre=:'Shooter' then genre='Action';
	if genre=:'Baseball' then genre='Action';
	if genre=:'Battle' then genre='Action';
	if genre=:'Pinball' then genre='Action';
	if genre=:'Pinball' then genre='Action';
	if genre=:'Sports' then genre='Action';
	if genre=:'Wrestling' then genre='Action';
	
	if genre =: 'Adventure' then genre='Adventure';
	if genre =: 'Other, Adventure' then genre='Adventure';
	
	if genre =: 'Banpresto' then genre ='Other';
	if genre =: 'Trivia' then genre='Other';
	
	if genre =: 'Music'  then genre='Misc';
	if genre =: 'Misc'  then genre='Misc';
	if genre =: 'Drama'  then genre='Misc';
	if genre =: 'Family'  then genre='Misc';
	if genre =: 'Musical' then genre='Misc';
	
	if genre=:'Strategy' then genre='Strategy';
	if genre=:'Platform' then genre='Strategy';
	if genre=:'Platformer' then genre='Strategy';
	if genre=:'Adult' then genre='Strategy';
	if genre=:'Board' then genre='Strategy';
	if genre=:'Card' then genre='Strategy';
	if genre=:'Casino' then genre='Strategy';
	if genre=:'Compilation' then genre='Strategy';
	if genre=:'Hardware' then genre='Strategy';
	
	if genre=:'Puzzle' then genre='Puzzle';
	if genre=:'Horror' then genre='Puzzle';
	if genre=:'Fantasy' then genre='Puzzle';
	if genre=:'Mystery' then genre='Puzzle';
	if genre=:'Thrill' then genre='Puzzle';
	
	
	if genre=:'RPG' then genre='Role-Playing';
	if genre=:'Party' then genre='Role-Playing';
	if genre=:'Virtual Pet' then genre='Role-Playing';

	if genre=:'Productivity' then genre='Simulation';
	if genre=:'Simulation' then genre='Simulation';
	
run;

data new_game1;
	set game1;
	if genre='Action' or genre='Adventure' or genre='Misc' or genre='Puzzle'
	or genre='Role-Playing' or genre='Simulation' or genre='Strategy';
run;

/* Check new dataset called game1*/
proc freq data=new_game1;
	title 'Table for frequence of genre for game1';
	tables genre;
run;

/*Calculate the average of genre's score for game1*/
proc sort data=new_game1 out=game1_sorted;
	by genre;
run;

data game_analysis;
	set game1_sorted;
	by genre;
	if first.genre then do;
	GenreTotal = 0;
	num=0;
	end;
	GenreTotal+score;
	num+1;
	if last.genre then do;
	VG_Avg = round(GenreTotal/num,0.001);
	output;
	end;
	keep Genre VG_Avg;
run;

proc print data=game_analysis noobs;
	title "Average of Genre's Score for game1";
run;

/*Clean the data and try to summarize the genre as 7 categories*/
data movie_genres;
	set project_movie;
	if genres =: 'Action' then genres='Action';
	if genres =: 'Adventure' then genres='Adventure';
	if genres =: 'Drama' then genres='Misc';
	if genres =: 'Family' then genres='Misc';
	if genres =: 'Music' then genres='Misc';
	if genres =: 'Musical' then genres='Misc';
	if genres =: 'Horror' then genres='Puzzle';
	if genres =: 'Fantasy' then genres='Puzzle';
	if genres =: 'Mystery' then genres='Puzzle';
	if genres =: 'Thrill' then genres='Puzzle';
	if genres =: 'Biography' then genres='Role-Playing';
	if genres =: 'Western' then genres='Role-Playing';
	if genres =: 'Documentary' then genres='Simulation';
	if genres =: 'Sci-Fi' then genres='Simulation';
	if genres =: 'Crime' then genres='Strategy';
run;

data movie_new;
	set movie_genres;
	if genres='Action' or genres='Adventure' or genres='Misc' or genres='Puzzle'
	or genres='Role-Playing' or genres='Simulation' or genres='Strategy';
run;

/*Check new dataset called movie_new*/
proc freq data=movie_new;
	title 'Table for frequence of genre for movie';
	tables genres;
run;

/*Calculate the average of genre's score for movie*/
proc sort data=movie_new out=order_movie;
	by genres;
run;

data score_movie;
	set order_movie(rename=(genres=genre));
	by genre;
	if first.genre then do;
	total=0;
	n=0;
	end;
	total+imdb_score;
	n+1;
	if last.genre then do;
	Movie_Ave=round(total/n,0.001);
	output;
	end;
	keep genre Movie_Ave;
run;

proc print data=score_movie noobs label;
	title "Average of Genre's Score for movie";
run;

/*Merge game1 and game2*/
proc sort data=score_movie out=score_movie_sorted;
	by genre;
run;

proc sort data=game_analysis out=game_analysis_sorted;
	by genre;
run;

data score_analysis;
	merge score_movie_sorted game_analysis_sorted;
	by genre;
run;

/*Clean the data and try to summarize the genre in 7 categories*/
data game2;
	set project_vsales;
	keep Genre Na_Sales EU_Sales JP_Sales Global_Sales;
	if Genre='Fighting' then Genre='Action';
	if Genre='Platform' then Genre='Strategy';
	if Genre='Racing' then Genre='Action';
	if Genre='Shooter' then Genre='Action';
	if Genre='Sports' then Genre='Action';
	where Genre='Action' or Genre='Adventure' or Genre='Misc' or Genre='Puzzle' or Genre='Role-Playing' or Genre='Simulation'or Genre='Strategy';
Run;

/* Check new dataset called game2*/
proc freq data=game2;
	title 'Table for frequence of genre for game2';
	tables genre;
run;

/*Calculate the average of genre's score for game2*/
proc sort data=game2 out=game2_sorted(keep=genre Global_Sales);
	by genre;
run;

data game2_genre_total;
	set game2_sorted;
	by genre;
	if first.genre then do;
		total=0;
		n=0;
	end;
	total+Global_Sales;
	n+1;
	if last.genre then do;
	Vg_sales_Ave=total/n;
	output;
	end;
	keep genre Vg_sales_Ave;
run;

proc print data=game2_genre_total noobs label;
	title 'Average Sales of game2';
run;

/*Merge game2 and the score_analysis*/
proc sort data=score_analysis out=score_analysis_sorted;
	by genre;
run;

proc sort data=game2_genre_total out=game2_genre_total_sorted;
	by genre;
run;

data overall_analysis;
	merge score_analysis_sorted game2_genre_total_sorted;
	by genre;
run;

proc sort data=overall_analysis out=overall_analysis_sorted;
	by descending Movie_Ave VG_Avg Vg_sales_Ave;
run;

proc print data=overall_analysis_sorted;
	title 'Overall Analysis for Seven Genres';
run;

