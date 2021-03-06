USE [wedding]
GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUser]
	@email nvarchar(50),
	@password nvarchar(50)
AS
BEGIN
	SELECT * FROM users
	WHERE email = @email AND pwd_hash = SUBSTRING(@password, 0, 50)
END

GO
/****** Object:  Table [dbo].[activities]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activities](
	[id_activity] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[id_event] [int] NOT NULL,
 CONSTRAINT [PK_activities] PRIMARY KEY CLUSTERED 
(
	[id_activity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[event_dates]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_dates](
	[id_date] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[id_event] [int] NOT NULL,
 CONSTRAINT [PK_event_date] PRIMARY KEY CLUSTERED 
(
	[id_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[events]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[id_event] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_events] PRIMARY KEY CLUSTERED 
(
	[id_event] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[guests]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[guests](
	[id_guest] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[id_user] [int] NOT NULL,
	[email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_guests] PRIMARY KEY CLUSTERED 
(
	[id_guest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[partecipations]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[partecipations](
	[id_partecipation] [int] IDENTITY(1,1) NOT NULL,
	[id_guest] [int] NOT NULL,
	[id_event] [int] NOT NULL,
 CONSTRAINT [PK_partecipations] PRIMARY KEY CLUSTERED 
(
	[id_partecipation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id_role] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 25/06/2018 10:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[id_role] [int] NOT NULL,
	[pwd_hash] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[activities]  WITH CHECK ADD  CONSTRAINT [FK_activities_events] FOREIGN KEY([id_event])
REFERENCES [dbo].[events] ([id_event])
GO
ALTER TABLE [dbo].[activities] CHECK CONSTRAINT [FK_activities_events]
GO
ALTER TABLE [dbo].[event_dates]  WITH CHECK ADD  CONSTRAINT [FK_event_dates_events] FOREIGN KEY([id_event])
REFERENCES [dbo].[events] ([id_event])
GO
ALTER TABLE [dbo].[event_dates] CHECK CONSTRAINT [FK_event_dates_events]
GO
ALTER TABLE [dbo].[guests]  WITH CHECK ADD  CONSTRAINT [FK_guests_users] FOREIGN KEY([id_user], [email])
REFERENCES [dbo].[users] ([id_user], [email])
GO
ALTER TABLE [dbo].[guests] CHECK CONSTRAINT [FK_guests_users]
GO
ALTER TABLE [dbo].[partecipations]  WITH CHECK ADD  CONSTRAINT [FK_partecipations_events] FOREIGN KEY([id_event])
REFERENCES [dbo].[events] ([id_event])
GO
ALTER TABLE [dbo].[partecipations] CHECK CONSTRAINT [FK_partecipations_events]
GO
ALTER TABLE [dbo].[partecipations]  WITH CHECK ADD  CONSTRAINT [FK_partecipations_guests] FOREIGN KEY([id_guest])
REFERENCES [dbo].[guests] ([id_guest])
GO
ALTER TABLE [dbo].[partecipations] CHECK CONSTRAINT [FK_partecipations_guests]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_roles] FOREIGN KEY([id_role])
REFERENCES [dbo].[roles] ([id_role])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_roles]
GO
