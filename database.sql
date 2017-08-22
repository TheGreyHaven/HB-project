--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Invitees; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE "Invitees" (
    inv_id integer NOT NULL,
    status character varying(20),
    i_email character varying(40),
    no_id integer
);


ALTER TABLE "Invitees" OWNER TO vagrant;

--
-- Name: Invitees_inv_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE "Invitees_inv_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Invitees_inv_id_seq" OWNER TO vagrant;

--
-- Name: Invitees_inv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE "Invitees_inv_id_seq" OWNED BY "Invitees".inv_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE categories (
    c_category_id integer NOT NULL,
    c_category character varying(40)
);


ALTER TABLE categories OWNER TO vagrant;

--
-- Name: categories_c_category_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE categories_c_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_c_category_id_seq OWNER TO vagrant;

--
-- Name: categories_c_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE categories_c_category_id_seq OWNED BY categories.c_category_id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE events (
    event_id integer NOT NULL,
    e_location character varying(100),
    "time" integer,
    date character varying(40),
    e_catergory_id integer,
    e_type character varying(100),
    e_link character varying(200),
    e_description text,
    e_name character varying(200) NOT NULL
);


ALTER TABLE events OWNER TO vagrant;

--
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE events_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE events_event_id_seq OWNER TO vagrant;

--
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE events_event_id_seq OWNED BY events.event_id;


--
-- Name: nightsout; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE nightsout (
    no_id integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    res_id integer
);


ALTER TABLE nightsout OWNER TO vagrant;

--
-- Name: nightsout_no_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE nightsout_no_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nightsout_no_id_seq OWNER TO vagrant;

--
-- Name: nightsout_no_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE nightsout_no_id_seq OWNED BY nightsout.no_id;


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE restaurants (
    res_id integer NOT NULL,
    r_location character varying(100) NOT NULL,
    r_catergory character varying(40),
    r_link character varying(40),
    r_price integer,
    r_name character varying(40) NOT NULL
);


ALTER TABLE restaurants OWNER TO vagrant;

--
-- Name: restaurants_res_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE restaurants_res_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE restaurants_res_id_seq OWNER TO vagrant;

--
-- Name: restaurants_res_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE restaurants_res_id_seq OWNED BY restaurants.res_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE users (
    user_id integer NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(20) NOT NULL
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: inv_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY "Invitees" ALTER COLUMN inv_id SET DEFAULT nextval('"Invitees_inv_id_seq"'::regclass);


--
-- Name: c_category_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY categories ALTER COLUMN c_category_id SET DEFAULT nextval('categories_c_category_id_seq'::regclass);


--
-- Name: event_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY events ALTER COLUMN event_id SET DEFAULT nextval('events_event_id_seq'::regclass);


--
-- Name: no_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY nightsout ALTER COLUMN no_id SET DEFAULT nextval('nightsout_no_id_seq'::regclass);


--
-- Name: res_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants ALTER COLUMN res_id SET DEFAULT nextval('restaurants_res_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: Invitees; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY "Invitees" (inv_id, status, i_email, no_id) FROM stdin;
\.


--
-- Name: Invitees_inv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('"Invitees_inv_id_seq"', 1, false);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY categories (c_category_id, c_category) FROM stdin;
103	Music
101	Business & Professional
110	Food & Drink
113	Community & Culture
105	Performing & Visual Arts
104	Film, Media & Entertainment
108	Sports & Fitness
107	Health & Wellness
102	Science & Technology
109	Travel & Outdoor
111	Charity & Causes
114	Religion & Spirituality
115	Family & Education
116	Seasonal & Holiday
112	Government & Politics
106	Fashion & Beauty
117	Home & Lifestyle
118	Auto, Boat & Air
119	Hobbies & Special Interest
199	Other
\.


--
-- Name: categories_c_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('categories_c_category_id_seq', 1, false);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY events (event_id, e_location, "time", date, e_catergory_id, e_type, e_link, e_description, e_name) FROM stdin;
1	1346 Saratoga Drive, San Mateo, CA 94403	\N	\N	110	\N	https://www.eventbrite.com/e/5th-annual-bacon-brew-fest-2017-tickets-36257051818?aff=ebapi	Celebrate with us! The San Mateo Area Chamber of Commerce is proud to welcome back the highly successful 5th Annual Bacon & Brew Fest which will be held Saturday, September 23, 2017, from 11:00 am to 7:00 pm.This year we are debuting the expanded event by partnering with the San Mateo County Events Center, and it will be held in the Central Mall at the Event Center.Beers from Your Favorite Breweries. Bacon Dishes from Local Restaurants and Food Trucks. Live Music from Journey Revisited, Aja Vu & Stealin’ Chicago, And Kickback. Margarita and Bloody Mary Bar. Specialty Foods | Arts & Crafts | Wine. Kid's Zone and Activities. Close to Hillsdale Caltrain, Uber And Bicycle Friendly.For sponsorship and corporate exhibitor opportunities, please contact:Lisa Eckles at Eckles Eventsecklesevents@gmail.com650-591-9120	5th Annual Bacon & Brew Fest 2017
2	229 West 20th Avenue, San Mateo, CA 94403	\N	\N	110	\N	https://www.eventbrite.com/e/3rd-annual-lobsterfest-tickets-36533904893?aff=ebapi	Our lobster fest will be served accross the table Maine style . Cost is $75 per person and all profits will be going to the Elk’s Major Project which benefits disabled children and thier familes the monies they neeed to help the kids to walk, talk, see and play.Menu:We’re hosting a traditional lobster bake, with appetizers and wine to start. Followed by a 1 ½ lb lobster per person and a bounty of clams, shrimp, and andouille sausage for everyone. The sides with dinner will be corn, potatoes and artichokes. We’ll be finishing the evening with dessert.  Chardonnay will be served throughout the evening; however, a cash bar is available at the Terrace Bar for those who prefer other spirits.  Space is limited, please RSVP by August 16th!	3rd Annual Lobsterfest
3	800 South B Street #400, San Mateo, CA 94401	\N	\N	103	\N	https://www.eventbrite.com/e/young-pianist-demo-class-age-6-to-8-tickets-36820150060?aff=ebapi	9/2/2017    Saturday    9:00 AM - 9:50 AMHappy Mozart Music School’s Young Pianist piano program is designed for children ages 6~8. This unique program focuses on building a solid foundation in the understanding and enjoyment of playing the piano.This free demo class gives the oppurtunity to take a look into our classes and view our techniques beforehand. For every class, we have special and different ways to learn which students tend to find helpful. No experience is needed for this program. Young Pianist Class informationSpace is limited, reserve your spot today!Register Your Spot Happy Mozart (650)525-9395    Email:Music@HappyMozart.com FAQsWho can I bring to the event?This is 1 Parent and 1 Student class for each family. Do I have to register for the demo class?Yes, please register online by click below's linkand pay the $20 deposit (deposti will refund when you attend the demo class)Register Your Spot	Young Pianist Demo Class (Age 6 to 8)
4	Eleanor Haas Koshland Center 2001 Winward Way, Suite 200, San Mateo, CA 94404	\N	\N	103	\N	https://www.eventbrite.com/e/music-together-birth-4-years-9-class-series-afternoon-session-two-registration-36114816388?aff=ebapi	Join this joyful musical experience for parents or caregivers and children, with singing, dancing, and instrument play. 9 Session dates: Thursdays, September 7- November 16, 2017.  This is the Afternoon Session TWO- 4:30 am to 5:15 pm session.  No Classes on 9/21 or 10/5.Join this joyful musical experience for parents or caregivers and children, with singing, dancing, and instrument play. $200 for 9 sessions for the first child; $125 for siblings at least 8 months old; Siblings 8 months and under are free. $74 for 2nd sibling, unless they are “multiples”.Multiple sibling pricing: Twin is $100; Triplet $50.  Fees include an illustrated songbook and two CDs for each family.        With: Steven Scholom, Peninsula Music Together.	Music Together (birth - 4 years) - 9 class series - Afternoon Session Two
5	1346 Saratoga Drive, San Mateo, CA 94403	\N	\N	110	\N	https://www.eventbrite.com/e/5th-annual-bacon-brew-fest-2017-tickets-36257051818?aff=ebapi	Celebrate with us! The San Mateo Area Chamber of Commerce is proud to welcome back the highly successful 5th Annual Bacon & Brew Fest which will be held Saturday, September 23, 2017, from 11:00 am to 7:00 pm.This year we are debuting the expanded event by partnering with the San Mateo County Events Center, and it will be held in the Central Mall at the Event Center.Beers from Your Favorite Breweries. Bacon Dishes from Local Restaurants and Food Trucks. Live Music from Journey Revisited, Aja Vu & Stealin’ Chicago, And Kickback. Margarita and Bloody Mary Bar. Specialty Foods | Arts & Crafts | Wine. Kid's Zone and Activities. Close to Hillsdale Caltrain, Uber And Bicycle Friendly.For sponsorship and corporate exhibitor opportunities, please contact:Lisa Eckles at Eckles Eventsecklesevents@gmail.com650-591-9120	5th Annual Bacon & Brew Fest 2017
6	229 West 20th Avenue, San Mateo, CA 94403	\N	\N	110	\N	https://www.eventbrite.com/e/3rd-annual-lobsterfest-tickets-36533904893?aff=ebapi	Our lobster fest will be served accross the table Maine style . Cost is $75 per person and all profits will be going to the Elk’s Major Project which benefits disabled children and thier familes the monies they neeed to help the kids to walk, talk, see and play.Menu:We’re hosting a traditional lobster bake, with appetizers and wine to start. Followed by a 1 ½ lb lobster per person and a bounty of clams, shrimp, and andouille sausage for everyone. The sides with dinner will be corn, potatoes and artichokes. We’ll be finishing the evening with dessert.  Chardonnay will be served throughout the evening; however, a cash bar is available at the Terrace Bar for those who prefer other spirits.  Space is limited, please RSVP by August 16th!	3rd Annual Lobsterfest
7	800 South B Street #400, San Mateo, CA 94401	\N	\N	103	\N	https://www.eventbrite.com/e/free-violin-group-class-demo-for-age-6-7-tickets-36374724781?aff=ebapi	8/25/2017    Friday    5:30 PMHappy Mozart Music School’s Little Mozart violin program is designed for children ages 6~7. This unique program focuses on building a solid foundation in the understanding and enjoyment of playing the violin.This free demo class gives the oppurtunity to take a look into our classes and view our techniques beforehand. For every class, we have special and different ways to learn which students tend to find helpful. No experience is needed for this program. More Information about Little Mozart Violin Classplease click link below to register::Register Your Spot Happy Mozart (650)525-9395    Email:Music@HappyMozart.com FAQsWhat should I bring to the event?You may need to bring your own violin to demo class.  If you dont have violin please let school know 1 week befor demo class. We'll prepare small size violins for students share in the class. Do I have to register for the demo class?Yes, please register online by click below's linkand pay the $20 deposit (deposti will refund when you attend the demo class)Register Your Spot	Free Violin Group Class Demo for Age 6 & 7
8	Eleanor Haas Koshland Center 2001 Winward Way, Suite 200, San Mateo, CA 94404	\N	\N	103	\N	https://www.eventbrite.com/e/music-together-birth-4-years-9-class-series-morning-session-one-registration-36075407515?aff=ebapi	Join this joyful musical experience for parents or caregivers and children, with singing, dancing, and instrument play. 9 Session dates: Thursdays, September 7- November 16, 2017.  This is the Morning Session ONE- 9:30 am to 10:15 am session.  No Classes on 9/21 or 10/5.Join this joyful musical experience for parents or caregivers and children, with singing, dancing, and instrument play. $200 for 9 sessions for the first child; $125 for siblings at least 8 months old; Siblings 8 months and under are free. $74 for 2nd sibling, unless they are “multiples”.Multiple sibling pricing: Twin is $100; Triplet $50.  Fees include an illustrated songbook and two CDs for each family.                With: Sami Kandeda, Peninsula Music Together.	Music Together (birth - 4 years) - 9 class series - Morning Session One
9	Eleanor Haas Koshland Center 2001 Winward Way, Suite 200, San Mateo, CA 94404	\N	\N	115	\N	https://www.eventbrite.com/e/meenakshis-international-cooking-with-kids-four-sessions-for-parents-with-children-2-8-years-registration-36116339945?aff=ebapi	Meenakshi's International Cooking with Kids- four sessions (for parents with children 2 - 8 years)During this program, children and parents or other caregivers will learn about the origin of cuisines and food sources. Each class will include songs, stories, and delicious vegetarian, kid-friendly, easy-to-make recipes from a different part of the world.  All the ingredients will be fresh and we will be responsive to any identified food allergies and adjust our recipes. $160 for Four sessions; $130 for siblings; fee includes the cost of ingredients. 4 Sessions, Wednesdays, October 25 - November 15, 4:30 pm - 5:30 pm With Meenakshi Mittal.Registration is available after the start date of the workshop based on availability.[Parent/Child Activity Groups][For Parents of Infants & Toddlers: Birth through Preschool][For Parents of Elementary School Aged Kids]   	Meenakshi's International Cooking with Kids - Four sessions (for parents with children 2 - 8 years)
10	Eleanor Haas Koshland Center 2001 Winward Way, Suite 200, San Mateo, CA 94404	\N	\N	115	\N	https://www.eventbrite.com/e/teaching-cooperation-without-stickers-snacks-or-screens-preschool-elementary-registration-33743264011?aff=ebapi	Teaching Cooperation Without Stickers, Snacks or Screens (Preschool - Elementary)Referencing Alfie Kohn's Punished by Rewards, we will explore how consequences and rewards can get in the way of children's growth and ability to learn. We will also look at how to use encouragement and praise to motivate your child to behave and cooperate.  With Lori Longo, MA.[For Parents of Elementary School Aged Kids]	Teaching Cooperation Without Stickers, Snacks or Screens (Preschool - Elementary)
11	Eleanor Haas Koshland Center 2001 Winward Way, San Mateo, CA 94404	\N	\N	115	\N	https://www.eventbrite.com/e/parenting-as-a-team-2-sessions-preschoolelementary-registration-36009102194?aff=ebapi	During this interactive, two-part workshop, couples will learn about the research, principles, strategies, and skills needed to strengthen the couple relationship. Participants will engage in class discussions and be given exercises to do both during and between sessions.With Susan Stone, BSE.  Fee: $160 for 2 sessions per couple.[For Parents of Infants & Toddlers: Birth through Preschool][For Parents of Elementary School Aged Kids]	Parenting As a Team - 2 Sessions (Preschool/Elementary) 
\.


--
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('events_event_id_seq', 11, true);


--
-- Data for Name: nightsout; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY nightsout (no_id, user_id, event_id, res_id) FROM stdin;
1	1	1	\N
2	1	2	\N
3	1	3	\N
4	1	4	\N
5	2	5	\N
6	2	6	\N
7	3	7	\N
8	3	8	\N
9	4	9	\N
10	4	10	\N
11	4	11	\N
\.


--
-- Name: nightsout_no_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('nightsout_no_id_seq', 11, true);


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY restaurants (res_id, r_location, r_catergory, r_link, r_price, r_name) FROM stdin;
\.


--
-- Name: restaurants_res_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('restaurants_res_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, password, email) FROM stdin;
1	123	happy@gmail.com
2	123	monday@gmail.com
3	123	hi@gmail.com
4	123	ari@gmail.com
5	123	ari@gmail.com
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 5, true);


--
-- Name: Invitees_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY "Invitees"
    ADD CONSTRAINT "Invitees_pkey" PRIMARY KEY (inv_id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (c_category_id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: nightsout_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY nightsout
    ADD CONSTRAINT nightsout_pkey PRIMARY KEY (no_id);


--
-- Name: restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (res_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: Invitees_no_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY "Invitees"
    ADD CONSTRAINT "Invitees_no_id_fkey" FOREIGN KEY (no_id) REFERENCES nightsout(no_id);


--
-- Name: events_e_catergory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_e_catergory_id_fkey FOREIGN KEY (e_catergory_id) REFERENCES categories(c_category_id);


--
-- Name: nightsout_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY nightsout
    ADD CONSTRAINT nightsout_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(event_id);


--
-- Name: nightsout_res_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY nightsout
    ADD CONSTRAINT nightsout_res_id_fkey FOREIGN KEY (res_id) REFERENCES restaurants(res_id);


--
-- Name: nightsout_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY nightsout
    ADD CONSTRAINT nightsout_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

