--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: favorite_songs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorite_songs (
    id integer NOT NULL,
    title text NOT NULL,
    artist text NOT NULL,
    year_of_release integer,
    album text,
    description text,
    youtube_link text,
    album_image_url text,
    votes integer DEFAULT 0
);


ALTER TABLE public.favorite_songs OWNER TO postgres;

--
-- Name: favorite_songs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favorite_songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorite_songs_id_seq OWNER TO postgres;

--
-- Name: favorite_songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favorite_songs_id_seq OWNED BY public.favorite_songs.id;


--
-- Name: song_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.song_votes (
    user_id text NOT NULL,
    song_id integer NOT NULL,
    vote integer NOT NULL,
    CONSTRAINT song_votes_vote_check CHECK ((vote = ANY (ARRAY['-1'::integer, 0, 1])))
);


ALTER TABLE public.song_votes OWNER TO postgres;

--
-- Name: favorite_songs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_songs ALTER COLUMN id SET DEFAULT nextval('public.favorite_songs_id_seq'::regclass);


--
-- Data for Name: favorite_songs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorite_songs (id, title, artist, year_of_release, album, description, youtube_link, album_image_url, votes) FROM stdin;
24	Down in a Hole	Alice in Chains	1992	Dirt	A melancholic track exploring themes of despair.	https://www.youtube.com/watch?v=f8hT3oDDf6c&list=RDf8hT3oDDf6c&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/f/f9/Dirt_%28Alice_in_Chains_album_-_cover_art%29.jpg/250px-Dirt_%28Alice_in_Chains_album_-_cover_art%29.jpg	0
22	You to Me Are Everything	The Real Thing	1976	Real Thing	A soulful love song with infectious rhythm.	https://www.youtube.com/watch?v=_aNxQ3xICqU&list=RD_aNxQ3xICqU&start_radio=1	https://i.scdn.co/image/ab67616d0000b273874698f8742583e90e88a6d6	0
25	Come as You Are	Nirvana	1991	Nevermind	A grunge classic with a hypnotic guitar riff.	https://www.youtube.com/watch?v=vabnZ9-ex7o	https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg	0
8	Alive	Pearl Jam	1991	Ten	An empowering anthem with a memorable guitar solo.	https://www.youtube.com/watch?v=3MutXUvS37k	https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/PearlJam-Ten2.jpg/250px-PearlJam-Ten2.jpg	0
3	Purple Rain	Prince	1984	Purple Rain	Epic ballad, full of passion and power – the guitar solo is unforgettable.	https://www.youtube.com/watch?v=TvnYmWpD_T8	https://m.media-amazon.com/images/I/81CzfbO4CrL.jpg	0
42	When Doves Cry	Prince	1984	Purple Rain	A groundbreaking track blending rock and funk.	https://www.youtube.com/watch?v=UG3VcCAlUgE	https://m.media-amazon.com/images/I/81CzfbO4CrL.jpg	0
31	Operator (That's Not the Way It Feels)	Jim Croce	1972	You Don't Mess Around with Jim	A narrative song about lost love and closure.	https://www.youtube.com/watch?v=khYxP7TiFSA&list=RDkhYxP7TiFSA&start_radio=1	https://upload.wikimedia.org/wikipedia/en/4/4a/Jim_Croce_-_You_Don%27t_Mess_Around_with_Jim.jpg	0
18	Cherub Rock	The Smashing Pumpkins	1993	Siamese Dream	A dynamic track with layered guitars and introspective lyrics.	https://www.youtube.com/watch?v=q-KE9lvU810	https://images.eil.com/large_image/SMASHING_PUMPKINS_SIAMESE%2BDREAM-97387.jpg	0
6	Wicked Game	Chris Isaak	1989	Heart Shaped World	A haunting ballad with emotional depth and atmospheric guitar work.	https://www.youtube.com/watch?v=oadhHk2xs6c	https://m.media-amazon.com/images/I/71546uJ1z2L._UF894,1000_QL80_.jpg	0
5	Sultans of Swing	Dire Straits	1978	Dire Straits	Iconic guitar work and cool narrative – smooth and skillful.	https://www.youtube.com/watch?v=8Pa9x9fZBtY	https://thequietus.com/app/uploads/2024/03/dire_straits_1540140904.jpg	0
7	Nutshell	Alice in Chains	1994	Jar of Flies	A poignant reflection on vulnerability and isolation.	https://www.youtube.com/watch?v=G23iLGhh9lo	https://upload.wikimedia.org/wikipedia/en/1/15/Alice_in_Chains_Jar_of_Flies.jpg	0
10	Man in the Box	Alice in Chains	1990	Facelift	A gritty song with powerful vocals and heavy guitar riffs.	https://www.youtube.com/watch?v=TAqZb52sgpU	https://images-eu.ssl-images-amazon.com/images/I/81yEBo5aO8L._AC_UL210_SR210,210_.jpg	0
11	There Is a Light That Never Goes Out	The Smiths	1986	The Queen Is Dead	A melancholic yet hopeful tune with poetic lyrics.	https://www.youtube.com/watch?v=siO6dkqidc4	https://upload.wikimedia.org/wikipedia/en/e/ed/The-Queen-is-Dead-cover.png	0
14	Closer	Nine Inch Nails	1994	The Downward Spiral	A provocative track with industrial beats and raw lyrics.	https://www.youtube.com/watch?v=PTFwQP86BRs	https://upload.wikimedia.org/wikipedia/en/3/3b/Official_Album_Cover_of_%22The_Downward_Spiral%22_by_Nine_Inch_Nails.png	0
15	Losing My Religion	R.E.M.	1991	Out of Time	A mandolin-driven song expressing doubt and obsession.	https://www.youtube.com/watch?v=xwtdhWltSIg	https://upload.wikimedia.org/wikipedia/en/9/9b/R.E.M._-_Out_of_Time.jpg	0
21	Take Me Home, Country Roads	John Denver	1971	Poems, Prayers & Promises	A heartfelt ode to West Virginia and homecoming.	https://www.youtube.com/watch?v=1vrEljMfXYo	https://upload.wikimedia.org/wikipedia/en/6/6b/Poems%2C_Prayers_and_Promises.jpg	0
2	Rain When I Die	Alice In Chains	1992	Dirt	Heavy and haunting – raw emotion and brooding tone.	https://www.youtube.com/watch?v=IPTHlmhtg8s&list=RDIPTHlmhtg8s&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/f/f9/Dirt_%28Alice_in_Chains_album_-_cover_art%29.jpg/250px-Dirt_%28Alice_in_Chains_album_-_cover_art%29.jpg	0
27	Brown Eyed Girl	Van Morrison	1967	Blowin' Your Mind!	An upbeat tune reminiscing youthful romance.	https://www.youtube.com/watch?v=UfmkgQRmmeE	https://upload.wikimedia.org/wikipedia/en/2/21/Blowin.yourmind.jpg	0
28	I Heard It Through the Grapevine	Marvin Gaye	1968	In the Groove	A soulful track about rumors and heartbreak.	https://www.youtube.com/watch?v=hajBdDM2qdg	https://upload.wikimedia.org/wikipedia/en/8/80/Marvin-gaye-in-the-groove.jpg	0
30	Black Hole Sun	Soundgarden	1994	Superunknown	A surreal and haunting grunge masterpiece.	https://www.youtube.com/watch?v=3mbBbFH9fAg	https://upload.wikimedia.org/wikipedia/en/3/3a/Superunknown.jpg	0
4	Dreams	Fleetwood Mac	1977	Rumours	Laid-back groove with mystical vocals – feels timeless.	https://www.youtube.com/watch?v=mrZRURcb1cM	https://upload.wikimedia.org/wikipedia/en/f/fb/FMacRumours.PNG	0
34	Insomnia	Faithless	1995	Reverence	An electronic track capturing the restlessness of sleepless nights.	https://www.youtube.com/watch?v=P8JEm4d6Wu4	https://upload.wikimedia.org/wikipedia/en/6/66/Faithless_Reverence.jpg	0
35	Drift Away	Dobie Gray	1973	Drift Away	A soulful plea for musical salvation.	https://www.youtube.com/watch?v=NIuyDWzctgY	https://i.scdn.co/image/ab67616d0000b27341bf81dd00d8f7788406d8d4	0
26	I Second That Emotion	Smokey Robinson & The Miracles	1967	Make It Happen	A Motown hit with smooth vocals and catchy hooks.	https://www.youtube.com/watch?v=mv9cWgkpIZ4&list=RDmv9cWgkpIZ4&start_radio=1	https://upload.wikimedia.org/wikipedia/en/b/b1/Miracles-make-it-happen.jpg	0
39	Send Me On My Way	Rusted Root	1994	When I Woke	An upbeat song with world music influences.	https://www.youtube.com/watch?v=IGMabBGydC0	https://upload.wikimedia.org/wikipedia/en/3/33/Rustedrootwheniwoke.jpg	0
40	Disco 2000	Pulp	1995	Different Class	A Britpop track reminiscing about youthful aspirations.	https://www.youtube.com/watch?v=qJS3xnD7Mus	https://upload.wikimedia.org/wikipedia/en/e/e1/Pulp_-_Different_Class.PNG	0
41	You Can Call Me Al	Paul Simon	1986	Graceland	A quirky song with African rhythms and humorous lyrics.	https://www.youtube.com/watch?v=uq-gYOrU8bA	https://upload.wikimedia.org/wikipedia/commons/c/c3/Graceland_cover_-_Paul_Simon.jpg	0
37	Train in Vain	The Clash	1979	London Calling	A punk-infused track about betrayal and resilience.	https://www.youtube.com/watch?v=aUzBgeI5dpc&list=RDaUzBgeI5dpc&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/0/00/TheClashLondonCallingalbumcover.jpg/250px-TheClashLondonCallingalbumcover.jpg	0
47	Lucky Man	The Verve	1997	Urban Hymns	A Britpop song celebrating contentment.	https://www.youtube.com/watch?v=MH6TJU0qWoY	https://upload.wikimedia.org/wikipedia/en/3/3e/The_Verve%2C_Urban_Hymns.png	0
49	Mayonaise	The Smashing Pumpkins	1993	Siamese Dream	An alternative rock song with dreamy textures.	https://www.youtube.com/watch?v=Vbu_K41efvY&list=RDVbu_K41efvY&start_radio=1	https://images.eil.com/large_image/SMASHING_PUMPKINS_SIAMESE%2BDREAM-97387.jpg	0
46	Landslide	Fleetwood Mac	1975	Fleetwood Mac	A gentle ballad reflecting on life's changes.	https://www.youtube.com/watch?v=WM7-PYtXtJM	https://upload.wikimedia.org/wikipedia/en/b/b1/Fleetwood_Mac_-_Fleetwood_Mac_%281975%29.png	0
48	Forgot About Dre	Dr. Dre featuring Eminem	1999	2001	A hip-hop track showcasing lyrical prowess.	https://www.youtube.com/watch?v=E5a93wABHNM	https://upload.wikimedia.org/wikipedia/en/5/56/DrDre-2001.jpg	0
51	Wish You Were Here	Pink Floyd	1975	Wish You Were Here	A heartfelt tribute to absence and loss, wrapped in Floyd’s classic sound.	https://www.youtube.com/watch?v=IXdNnw99-Ic	https://upload.wikimedia.org/wikipedia/en/a/a4/Pink_Floyd%2C_Wish_You_Were_Here_%281975%29.png	0
45	True Faith	New Order	1987	Substance 1987	A synth-pop track with melancholic undertones.	https://www.youtube.com/watch?v=mfI1S0PKJR8&list=RDmfI1S0PKJR8&start_radio=1	https://upload.wikimedia.org/wikipedia/commons/c/c4/SubstanceCoverBig.jpg	0
55	Born Slippy	Underworld	1995	Trainspotting Soundtrack / Second Toughest in the Infants	Rave-era euphoria with hypnotic vocals – a club culture cornerstone.	https://www.youtube.com/watch?v=TlLWFa1b1Bc	https://upload.wikimedia.org/wikipedia/en/3/36/Second_Toughest_in_the_Infants.jpg	0
57	Seven Nation Army	The White Stripes	2003	Elephant	A stadium-shaking anthem with one of rock's most recognizable riffs.	https://www.youtube.com/watch?v=0J2QdDbelmY	https://upload.wikimedia.org/wikipedia/en/thumb/1/11/Elephant%2C_The_White_Stripes.png/250px-Elephant%2C_The_White_Stripes.png	0
59	September	Earth, Wind & Fire	1978	The Best of Earth, Wind & Fire, Vol. 1	Pure joy and disco energy that never gets old.	https://www.youtube.com/watch?v=Gs069dndIYk	https://upload.wikimedia.org/wikipedia/en/9/95/BestofEarthWind%26Fire.jpg	0
54	Live Forever	Oasis	1994	Definitely Maybe	A defiant anthem of youth and immortality.	https://www.youtube.com/watch?v=TDe1DqxwJoc&list=RDTDe1DqxwJoc&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/d/d4/OasisDefinitelyMaybealbumcover.jpg/250px-OasisDefinitelyMaybealbumcover.jpg	0
61	Beautiful Ones	Suede	1996	Coming Up	Glam rock revival bursting with swagger and color.	https://www.youtube.com/watch?v=xqovGKdgAXY&list=RDxqovGKdgAXY&start_radio=1	https://upload.wikimedia.org/wikipedia/en/0/03/Coming_Up.jpg	0
62	Glory Box	Portishead	1994	Dummy	Sensual and moody – a trip-hop staple.	https://www.youtube.com/watch?v=4qQyUi4zfDs&list=RD4qQyUi4zfDs&start_radio=1	https://upload.wikimedia.org/wikipedia/en/6/6b/Portishead_-_Dummy.png	0
65	Smooth	Santana and Rob Thomas	1999	Supernatural	A Latin rock groove with unforgettable hooks.	https://www.youtube.com/watch?v=6Whgn_iE5uc	https://upload.wikimedia.org/wikipedia/en/thumb/7/7f/Santana_-_Supernatural_-_CD_album_cover.jpg/250px-Santana_-_Supernatural_-_CD_album_cover.jpg	0
67	No Diggity	Blackstreet	1996	Another Level	Silky smooth R&B with slick beats and vocal charisma.	https://www.youtube.com/watch?v=3KL9mRus19o	https://upload.wikimedia.org/wikipedia/en/7/72/BlackstreetAnotherLevelAlbum.jpg	0
63	Fast Car	Tracy Chapman	1988	Tracy Chapman	A quietly powerful story of struggle and escape.	https://www.youtube.com/watch?v=AIOAlaACuv4&list=RDAIOAlaACuv4&start_radio=1	https://upload.wikimedia.org/wikipedia/en/3/3d/Tracy_Chapman_-_Tracy_Chapman.jpg	0
70	Still Got the Blues	Gary Moore	1990	Still Got the Blues	Blistering blues guitar and heartfelt vocals.	https://www.youtube.com/watch?v=4O_YMLDvvnw	https://upload.wikimedia.org/wikipedia/en/f/f2/Stillgottheblues.jpg	0
71	Addicted to Love	Robert Palmer	1986	Riptide	80s rock swagger with one of the most iconic videos.	https://www.youtube.com/watch?v=XcATvu5f9vE	https://upload.wikimedia.org/wikipedia/en/3/30/Robert_Palmer_Riptide_album.jpg	0
72	Love Shack	The B-52s	1989	Cosmic Thing	Wild, fun, and impossible not to dance to.	https://www.youtube.com/watch?v=9SOryJvTAGs	https://upload.wikimedia.org/wikipedia/en/b/be/The_B-52%27s_-_Cosmic_Thing.jpg	0
68	Born on the Bayou	Creedence Clearwater Revival	1969	Bayou Country	Swamp rock classic with gritty vocals and southern vibe.	https://www.youtube.com/watch?v=fcTQCNntGEs&list=RDfcTQCNntGEs&start_radio=1	https://upload.wikimedia.org/wikipedia/en/3/37/Creedence_Clearwater_Revival_-_Bayou_Country.jpg	0
77	Regulate	Nate Dogg and Warren G	1994	Regulate... G Funk Era	Smooth G-funk classic with storytelling swagger.	https://www.youtube.com/watch?v=1plPyJdXKIY	https://upload.wikimedia.org/wikipedia/en/5/5b/Regulate_G_Funk_Era.jpg	0
74	Comfortably Numb	Pink Floyd	1979	The Wall	Transcendent guitar solos and dreamlike emotion.	https://www.youtube.com/watch?v=7kWl-ZGMwkQ&list=RD7kWl-ZGMwkQ&start_radio=1	https://i.pinimg.com/736x/76/83/c3/7683c3600439d23017fa168c5738b8df.jpg	0
78	Semi-Charmed Life	Third Eye Blind	1997	Third Eye Blind	Catchy 90s alt-pop with darker lyrical undertones.	www.youtube.com/watch?v=beINamVRGy4&list=RDbeINamVRGy4&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/d/da/Third_eye_blind_self_titled.jpg/250px-Third_eye_blind_self_titled.jpg	0
81	Give It Up	KC and the Sunshine Band	1983	KC Ten	Disco-funk delight that gets everyone moving.	https://www.youtube.com/watch?v=GWqshuTyqjA&list=RDGWqshuTyqjA&start_radio=1	https://upload.wikimedia.org/wikipedia/en/0/07/KCTEN.jpg	0
83	Who Is He (And What Is He to You)?	Bill Withers	1972	Still Bill	Soulful and funky tale of suspicion and betrayal.	https://www.youtube.com/watch?v=T4JtCCWB6Y4&list=RDT4JtCCWB6Y4&start_radio=1	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Still_Bill.jpg/640px-Still_Bill.jpg	0
84	Set You Free	N-Trance	1995	Electronic Pleasure	A euphoric rave anthem full of emotional highs.	https://www.youtube.com/watch?v=MYVmMweuPxk&list=RDMYVmMweuPxk&start_radio=1	https://upload.wikimedia.org/wikipedia/en/8/87/N-Trance-Electronic_Pleasure.jpg	0
87	Virtual Insanity	Jamiroquai	1996	Travelling Without Moving	Funky futurism with one of the coolest music videos.	https://www.youtube.com/watch?v=4JkIs37a2JE	https://upload.wikimedia.org/wikipedia/en/thumb/5/5a/Travellingwithoutmoving.png/250px-Travellingwithoutmoving.png	0
85	Step On	Happy Mondays	1990	Pills 'n' Thrills and Bellyaches	Madchester groove with attitude and bounce.	https://www.youtube.com/watch?v=mFBQ0PH5rM4&list=RDmFBQ0PH5rM4&start_radio=1	https://upload.wikimedia.org/wikipedia/en/5/5c/Hmpillsnthrills.jpg	0
38	The Boxer	Simon & Garfunkel	1969	Bridge over Troubled Water	A folk ballad depicting the struggles of a young man.	https://www.youtube.com/watch?v=l3LFML_pxlY	https://upload.wikimedia.org/wikipedia/en/4/41/Simon_and_Garfunkel%2C_Bridge_over_Troubled_Water_%281970%29.png	0
58	Simple Man	Lynyrd Skynyrd	1973	(Pronounced 'Leh-'nérd 'Skin-'nérd)	A heartfelt ballad filled with Southern wisdom and soul.	https://www.youtube.com/watch?v=sMmTkKz60W8	https://m.media-amazon.com/images/I/71yEmlSRU9L.jpg	0
13	Smells Like Teen Spirit	Nirvana	1991	Nevermind	An iconic grunge anthem that defined a generation.	https://www.youtube.com/watch?v=hTWKbfoikeg	https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg	0
17	Black	Pearl Jam	1991	Ten	An emotional ballad about lost love and longing.	https://www.youtube.com/watch?v=cs-XZ_dN4Hc	https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/PearlJam-Ten2.jpg/250px-PearlJam-Ten2.jpg	0
52	Bittersweet Symphony	The Verve	1997	Urban Hymns	Sweeping orchestration meets existential angst in this Britpop classic.	https://www.youtube.com/watch?v=1lyu1KKwC74	https://upload.wikimedia.org/wikipedia/en/3/3e/The_Verve%2C_Urban_Hymns.png	0
20	Stairway to Heaven	Led Zeppelin	1971	Led Zeppelin IV	An epic composition blending folk and hard rock elements.	https://www.youtube.com/watch?v=QkF3oxziUI4	https://m.media-amazon.com/images/I/81x364UAGAL.jpg	0
92	When the Levee Breaks	Led Zeppelin	1971	Led Zeppelin IV	Thunderous blues-rock driven by legendary drumming.	https://www.youtube.com/watch?v=uwiTs60VoTM	https://m.media-amazon.com/images/I/81x364UAGAL.jpg	0
1	Sittin’ on the Dock of the Bay	Otis Redding	1968	The Dock of the Bay	Timeless soul track that evokes peace and melancholy.	https://www.youtube.com/watch?v=rTVjnBo96Ug	https://upload.wikimedia.org/wikipedia/en/e/ee/Otisdockofthebay.jpg	0
12	Islands in the Stream	Dolly Parton and Kenny Rogers	1983	Eyes That See in the Dark	A classic duet with harmonious vocals and catchy melody.	https://www.youtube.com/watch?v=UaNGtgYwSsU	https://upload.wikimedia.org/wikipedia/en/0/01/Kenny_Rogers-Eyes_That_See.jpg	0
29	Sunshine of Your Love	Cream	1967	Disraeli Gears	A psychedelic rock song with a memorable riff.	https://www.youtube.com/watch?v=zt51rITH3EA	https://upload.wikimedia.org/wikipedia/en/c/cb/DisraeliGears.jpg	0
43	Outshined	Soundgarden	1991	Badmotorfinger	A heavy grunge song with introspective lyrics.	https://www.youtube.com/watch?v=sNh-iw7gsuI	https://upload.wikimedia.org/wikipedia/en/6/63/Soundgarden_-_Badmotorfinger.jpg	0
53	Don't Dream It's Over	Crowded House	1986	Crowded House	A melodic tune about hope and perseverance amid life's obstacles.	https://www.youtube.com/watch?v=J9gKyRmic20	https://upload.wikimedia.org/wikipedia/en/2/21/Crowded_house_-_ch.jpg	0
56	Sabotage	Beastie Boys	1994	Ill Communication	Frenetic energy, iconic bassline – a punk/hip-hop fusion.	https://www.youtube.com/watch?v=z5rRZdiu1UE	https://i.discogs.com/fjZGJHr59oe8cIf2N9L-8aJOJpUjotK5CcUrRGiRYB4/rs:fit/g:sm/q:40/h:300/w:300/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTE3Nzgy/OTEyLTE2MTU0MDY2/MTMtMjUyNi5qcGVn.jpeg	0
89	Cult of Personality	Living Colour	1988	Vivid	A searing rock track examining politics and influence.	https://www.youtube.com/watch?v=7xxgRUyzgs0	https://upload.wikimedia.org/wikipedia/en/0/0e/Living_Colour-Vivid.jpg	0
91	Unfinished Sympathy	Massive Attack	1991	Blue Lines	A lush and emotional trip-hop masterpiece.	https://www.youtube.com/watch?v=ZWmrfgj0MZI	https://upload.wikimedia.org/wikipedia/en/a/a7/MassiveAttackBlueLines.jpg	0
93	Piano Man	Billy Joel	1973	Piano Man	Iconic storytelling and sing-along piano melodies.	https://www.youtube.com/watch?v=gxEPV4kolz0	https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Billy_Joel_-_Piano_Man.jpg/640px-Billy_Joel_-_Piano_Man.jpg	0
95	White Wine in the Sun	Tim Minchin	2009	Ready for This?	A modern, heartfelt Christmas song filled with love and wit.	https://www.youtube.com/watch?v=fCNvZqpa-7Q	https://upload.wikimedia.org/wikipedia/en/1/11/Readyforthiscover.jpg	0
98	Jack and Diane	John Mellencamp	1982	American Fool	A nostalgic snapshot of American youth.	https://www.youtube.com/watch?v=h04CH9YZcpI	https://upload.wikimedia.org/wikipedia/en/2/2c/JC_American_Fool.jpg	0
75	Free Bird	Lynyrd Skynyrd	1973	(Pronounced 'Leh-'nérd 'Skin-'nérd)	A southern rock epic with a legendary solo.	https://www.youtube.com/watch?v=0LwcvjNJTuM&list=RD0LwcvjNJTuM&start_radio=1	https://m.media-amazon.com/images/I/71yEmlSRU9L.jpg	0
97	Karma Chameleon	Culture Club	1983	Colour by Numbers	A vibrant pop anthem about identity, truth, and change, wrapped in iconic '80s style.	https://www.youtube.com/watch?v=JmcA9LIIXWw&list=RDJmcA9LIIXWw&start_radio=1	https://upload.wikimedia.org/wikipedia/en/9/9f/CultureClubColourByNumbersAlbumcover.jpg	0
36	The Whole of the Moon	The Waterboys	1985	This Is the Sea	An expansive song celebrating visionary thinking.	https://www.youtube.com/watch?v=0eL-jEV_RKM&list=RD0eL-jEV_RKM&start_radio=1	https://upload.wikimedia.org/wikipedia/en/6/68/This_Is_The_Sea_Waterboys_Album_Cover.jpg	0
33	Goodbye Stranger	Supertramp	1979	Breakfast in America	A pop-rock tune with catchy melodies and harmonies.	https://www.youtube.com/watch?v=u8pVZ5hTGJQ&list=RDu8pVZ5hTGJQ&start_radio=1	https://upload.wikimedia.org/wikipedia/en/c/c4/Supertramp_-_Breakfast_in_America.jpg	0
9	Breathe	The Prodigy	1996	The Fat of the Land	An energetic track that captures the essence of 90s electronic music.	https://www.youtube.com/watch?v=rmHDhAohJlQ&list=RDrmHDhAohJlQ&start_radio=1	https://upload.wikimedia.org/wikipedia/en/3/3b/TheProdigy-TheFatOfTheLand.jpg	0
23	Tiny Dancer	Elton John	1971	Madman Across the Water	A piano-driven ballad celebrating a free-spirited muse.	https://www.youtube.com/watch?v=5g4MSYK5d3A&list=RD5g4MSYK5d3A&start_radio=1	https://upload.wikimedia.org/wikipedia/en/d/d4/Elton_John_-_Madman_Across_the_Water.jpg	0
16	Gimme Shelter	The Rolling Stones	1969	Let It Bleed	A powerful song reflecting the turbulence of the 60s.	https://www.youtube.com/watch?v=RbmS3tQJ7Os&list=RDRbmS3tQJ7Os&start_radio=1	https://upload.wikimedia.org/wikipedia/en/c/c0/LetitbleedRS.jpg	0
32	Tuesday's Gone	Lynyrd Skynyrd	1973	(Pronounced 'Lĕh-'nérd 'Skin-'nérd)	A southern rock ballad about moving on.	https://www.youtube.com/watch?v=_7p2ogicS1U&list=RD_7p2ogicS1U&start_radio=1	https://m.media-amazon.com/images/I/71yEmlSRU9L.jpg	0
19	The Chain	Fleetwood Mac	1977	Rumours	A song showcasing the bands unity and musical synergy.	https://www.youtube.com/watch?v=xwTPvcPYaOo&list=RDxwTPvcPYaOo&start_radio=1	https://upload.wikimedia.org/wikipedia/en/f/fb/FMacRumours.PNG	0
60	No One Knows	Queens of the Stone Age	2002	Songs for the Deaf	Groovy and mysterious – modern rock at its best.	https://www.youtube.com/watch?v=s88r_q7oufE	https://upload.wikimedia.org/wikipedia/en/0/01/Queens_of_the_Stone_Age_-_Songs_for_the_Deaf.png	0
66	Runaway Train	Soul Asylum	1993	Grave Dancers Union	Emotive alt-rock tackling themes of loss and rescue.	https://www.youtube.com/watch?v=NRtvqT_wMeY	https://upload.wikimedia.org/wikipedia/en/7/75/Soul_Asylum_Grave_Dancer%27s_Union.jpg	0
69	I Still Haven't Found What I'm Looking For	U2	1987	The Joshua Tree	Spiritual longing expressed in anthemic rock.	https://www.youtube.com/watch?v=e3-5YC_oHjE	https://upload.wikimedia.org/wikipedia/en/6/6b/The_Joshua_Tree.png	0
73	Running Up That Hill	Kate Bush	1985	Hounds of Love	Powerful and otherworldly – an emotional synth-pop gem.	https://www.youtube.com/watch?v=wp43OdtAAkM	https://upload.wikimedia.org/wikipedia/en/3/3f/Katebushhoundsoflove.png	0
79	You Get What You Give	New Radicals	1998	Maybe You've Been Brainwashed Too	An uplifting anthem of youthful rebellion and hope.	https://www.youtube.com/watch?v=DL7-CKirWZE	https://upload.wikimedia.org/wikipedia/en/2/22/NewRadicalsMYBBT.jpg	0
82	Fairytale of New York	The Pogues and Kirsty MacColl	1987	If I Should Fall from Grace with God	A gritty, poetic Christmas song with unmatched character.	https://www.youtube.com/watch?v=j9jbdgZidu8	https://upload.wikimedia.org/wikipedia/en/1/14/If_I_Should_Fall_From_Grace_With_God_alt.jpg	0
90	Zombie	The Cranberries	1994	No Need to Argue	Haunting protest song with unforgettable vocals.	https://www.youtube.com/watch?v=6Ejga4kJUts	https://upload.wikimedia.org/wikipedia/en/thumb/2/2c/CranberriesNoNeedToArgueAlbumcover.jpg/250px-CranberriesNoNeedToArgueAlbumcover.jpg	0
94	Solsbury Hill	Peter Gabriel	1977	Peter Gabriel (Car)	An uplifting song about change and personal transformation.	https://www.youtube.com/watch?v=WeYqJxlSv-Y	https://upload.wikimedia.org/wikipedia/en/f/f8/Peter_Gabriel_%28self-titled_album%2C_1977_-_cover_art%29.jpg	0
99	Maybe Tomorrow	Stereophonics	2003	You Gotta Go There to Come Back	Reflective and hopeful with a smooth groove.	https://www.youtube.com/watch?v=2q9_ZEtuTR8&list=RD2q9_ZEtuTR8&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Yggttcb.jpg/250px-Yggttcb.jpg	0
88	Ratamahatta	Sepultura	1996	Roots	Tribal drums and Brazilian metal energy in full force.	https://www.youtube.com/watch?v=NiwqRSCWw2g&list=RDNiwqRSCWw2g&start_radio=1	https://upload.wikimedia.org/wikipedia/en/c/cf/Sepultura_-_Roots.jpg	0
80	Freed from Desire	Gala	1996	Come into My Life	Eurodance energy with an irresistible chorus.	https://www.youtube.com/watch?v=p3l7fgvrEKM&list=RDp3l7fgvrEKM&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/c/c6/Gala_-_Come_into_My_Life_%281997%29.jpeg/250px-Gala_-_Come_into_My_Life_%281997%29.jpeg	0
96	Electric Relaxation	A Tribe Called Quest	1993	Midnight Marauders	Smooth beats and smart lyrics – hip-hop chill perfection.	https://www.youtube.com/watch?v=WHRnvjCkTsw	https://smarthomesounds.sirv.com/live-magento/catalog/product/m/i/midnight-marauders-lp-a-tribe-called-quest-album-cover-hero.jpg?profile=smarthome&q=80&canvas.width=450&canvas.height=450&canvas.color=ffffff&w=450&h=450	0
76	Dakota	Stereophonics	2005	Language. Sex. Violence. Other?	A powerful Brit-rock anthem with a sense of yearning.	https://www.youtube.com/watch?v=SzBJQnD7TRM&list=RDSzBJQnD7TRM&start_radio=1	https://upload.wikimedia.org/wikipedia/en/c/c5/Language._Sex._Violence._Other%3F_%28album_cover%29.jpg	0
64	Weather With You	Crowded House	1992	Woodface	Gentle and poetic – the sound of introspective pop.	https://www.youtube.com/watch?v=ag8XcMG1EX4&list=RDag8XcMG1EX4&start_radio=1	https://upload.wikimedia.org/wikipedia/en/b/bf/Crowded_House-Woodface_%28album_cover%29.jpg	0
50	River of Deceit	Mad Season	1995	Above	A grunge track with soulful vocals and introspective lyrics.	https://www.youtube.com/watch?v=Fm72DPJCX58&list=RDFm72DPJCX58&start_radio=1	https://upload.wikimedia.org/wikipedia/en/7/7d/Above_%28Mad_Season_album%29.jpeg	0
44	Night Moves	Bob Seger	1976	Night Moves	A nostalgic song about teenage romance.	https://www.youtube.com/watch?v=xH7cSSKnkL4&list=RDxH7cSSKnkL4&start_radio=1	https://upload.wikimedia.org/wikipedia/en/thumb/0/00/Bob_Seger_-_Night_Moves.jpg/250px-Bob_Seger_-_Night_Moves.jpg	0
86	(Rock) Superstar	Cypress Hill	2000	Skull & Bones	A raw reflection on fame in the rap-rock hybrid style.	https://www.youtube.com/watch?v=W4VpE-0zitU&list=RDW4VpE-0zitU&start_radio=1	https://upload.wikimedia.org/wikipedia/en/c/c4/Cypress_Hill_Skull_%26_Bones.jpg	0
100	Operation Blade	Public Domain	2000	Hard Hop Superstars	High-octane techno with cinematic flair.	https://www.youtube.com/watch?v=ed8otHRhrBI&list=RDed8otHRhrBI&start_radio=1	https://i.discogs.com/jH7MIqttjsVQfUMWVciKQ7kZnWU1o9t3-yXgJwWrrjs/rs:fit/g:sm/q:90/h:400/w:400/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTYyNTgx/NzItMTQxNTAwMzEw/Ny02OTc2LmpwZWc.jpeg	0
\.


--
-- Data for Name: song_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.song_votes (user_id, song_id, vote) FROM stdin;
5fa419fc-a6ff-4f61-b80d-3f69538acfd9	99	0
5fa419fc-a6ff-4f61-b80d-3f69538acfd9	11	0
5fa419fc-a6ff-4f61-b80d-3f69538acfd9	100	-1
5fa419fc-a6ff-4f61-b80d-3f69538acfd9	96	0
5fa419fc-a6ff-4f61-b80d-3f69538acfd9	31	0
5fa419fc-a6ff-4f61-b80d-3f69538acfd9	98	0
\.


--
-- Name: favorite_songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorite_songs_id_seq', 100, true);


--
-- Name: favorite_songs favorite_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_songs
    ADD CONSTRAINT favorite_songs_pkey PRIMARY KEY (id);


--
-- Name: song_votes song_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_votes
    ADD CONSTRAINT song_votes_pkey PRIMARY KEY (user_id, song_id);


--
-- Name: song_votes song_votes_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_votes
    ADD CONSTRAINT song_votes_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.favorite_songs(id);


--
-- PostgreSQL database dump complete
--

