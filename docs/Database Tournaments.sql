USE [Tournaments]
GO
/****** Object:  Table [dbo].[MatchupEntries]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchupEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MatchupId] [int] NOT NULL,
	[ParentMatchupId] [int] NULL,
	[TeamCompetingId] [int] NULL,
	[Score] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Matchups]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matchups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[WinnerId] [int] NULL,
	[MatchupRound] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[EmailAddress] [nvarchar](100) NOT NULL,
	[CellphoneNumber] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prizes]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prizes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlaceNumber] [int] NOT NULL,
	[PlaceName] [nvarchar](50) NOT NULL,
	[PrizeAmount] [money] NOT NULL,
	[PrizePercentage] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMembers]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_TeamMembers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentEntries]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentPrizes]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentPrizes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[PrizeId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tournaments]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournaments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentName] [nvarchar](200) NOT NULL,
	[EntryFee] [money] NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Prizes] ADD  DEFAULT ((0)) FOR [PrizeAmount]
GO
ALTER TABLE [dbo].[Prizes] ADD  DEFAULT ((0)) FOR [PrizePercentage]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH NOCHECK ADD  CONSTRAINT [FK_MatchupEntries_Matchup] FOREIGN KEY([MatchupId])
REFERENCES [dbo].[Matchups] ([Id])
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Matchup]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH NOCHECK ADD  CONSTRAINT [FK_MatchupEntries_ParentMatchupId] FOREIGN KEY([ParentMatchupId])
REFERENCES [dbo].[Matchups] ([Id])
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_ParentMatchupId]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH NOCHECK ADD  CONSTRAINT [FK_MatchupEntries_Teams] FOREIGN KEY([TeamCompetingId])
REFERENCES [dbo].[Teams] ([Id])
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Teams]
GO
ALTER TABLE [dbo].[Matchups]  WITH CHECK ADD  CONSTRAINT [FK_Matchups_Teams] FOREIGN KEY([WinnerId])
REFERENCES [dbo].[Teams] ([Id])
GO
ALTER TABLE [dbo].[Matchups] CHECK CONSTRAINT [FK_Matchups_Teams]
GO
ALTER TABLE [dbo].[Matchups]  WITH CHECK ADD  CONSTRAINT [FK_Matchups_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([Id])
GO
ALTER TABLE [dbo].[Matchups] CHECK CONSTRAINT [FK_Matchups_Tournaments]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([Id])
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_Teams]
GO
ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([Id])
GO
ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_Teams]
GO
ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([Id])
GO
ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_Tournaments]
GO
ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_Prizes] FOREIGN KEY([PrizeId])
REFERENCES [dbo].[Prizes] ([Id])
GO
ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_Prizes]
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_GetByTournament]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchupEntries_GetByTournament]
	@MatchupId int 
AS
begin
	set nocount on;

	select * from dbo.MatchupEntries   
	where  MatchupId = @MatchupId;
	 

end
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchupEntries_Insert]
	@MatchupId int,  
	@ParentMatchupId int,
	@TeamCompetingId int, 
	@Id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.MatchupEntries(MatchupId,ParentMatchupId, TeamCompetingId)
		values(@MatchupId,@ParentMatchupId,@TeamCompetingId); 

	Select @Id = SCOPE_IDENTITY();

end
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_Update]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchupEntries_Update]
	@Id int,
	@TeamCompetingId int = null,
	@Score float = null
AS
begin
	set nocount on;

	update dbo.MatchupEntries 
	set @TeamCompetingId = @TeamCompetingId, Score = @Score
	where id = @Id;	

end
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_GetByTournament]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spMatchups_GetByTournament]
	@TournamentId int 
AS
begin
	set nocount on;

	select m.* from dbo.Matchups m  
	where m.TournamentId = @TournamentId
	order by MatchupRound;
	 

end
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchups_Insert]
	@TournamentId int,  
	@MatchupRound int,
	@Id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.Matchups(TournamentId,MatchupRound)
		values(@TournamentId,@MatchupRound); 

	Select @Id = SCOPE_IDENTITY();

end
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_Update]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchups_Update]
	@Id int,
	@WinnerId int
AS
begin
	set nocount on;

	update dbo.Matchups 
	set WinnerId = @WinnerId
	where id = @Id;	

end
GO
/****** Object:  StoredProcedure [dbo].[spPeople_GetAll]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPeople_GetAll]	 
AS
begin
	set nocount on;
	 
	select * from People;

end
GO
/****** Object:  StoredProcedure [dbo].[spPeople_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPeople_Insert]
	@FirstName nvarchar(100),
	@LastName nvarchar(100),
	@EmailAddress nvarchar(100),
	@CellphoneNumber nvarchar(20),
	@id int = 0 output
AS
begin
	set nocount on;

	Insert into dbo.People  (FirstName,LastName, EmailAddress,CellphoneNumber)
		values(@FirstName, @LastName, @EmailAddress, @CellphoneNumber);

	select @id = SCOPE_IDENTITY();


end
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_GetByTournament]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPrizes_GetByTournament]
	@TournamentId int 
AS
begin
	set nocount on;

	select p.* from dbo.Prizes p inner join dbo.TournamentPrizes t on p.Id = t.Id
	where t.TournamentId = @TournamentId;
	 

end
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spPrizes_Insert]
	@PlaceNumber int,
	@PlaceName nvarchar(50),
	@PrizeAmount money,
	@PrizePercentage float,
	@id int = 0 output
as 
begin 
	set nocount on;
	
	insert into dbo.Prizes (PlaceNumber, PlaceName, PrizeAmount, PrizePercentage)
	values(@PlaceNumber, @PlaceName, @PrizeAmount, @PrizePercentage);
	
	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTeam_GetAll]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeam_GetAll]	 
	 
AS
begin
	set nocount on;
	 
	select * from Teams  

end
GO
/****** Object:  StoredProcedure [dbo].[spTeam_GetByTournament]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeam_GetByTournament]
	@TournamentId int 
AS
begin
	set nocount on;

	select te.* from dbo.Teams te inner join dbo.TournamentPrizes e on te.Id = e.Id
	where e.TournamentId = @TournamentId;
	 

end
GO
/****** Object:  StoredProcedure [dbo].[spTeamMembers_GetByTeam]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeamMembers_GetByTeam]
	 @TeamId int
AS
begin
	set nocount on;
	 
	select p.* from dbo.TeamMembers m 
		inner join dbo.People p on m.PersonId = p.Id
		where m.TeamId = @TeamId;

end
GO
/****** Object:  StoredProcedure [dbo].[spTeamMembers_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeamMembers_Insert]
	@TeamId int, 
	@PersonId int,
	@id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.TeamMembers(TeamId, PersonId)
		values(@TeamId, @PersonId);

	select @id = SCOPE_IDENTITY();


end
GO
/****** Object:  StoredProcedure [dbo].[spTeams_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeams_Insert]
	@TeamName nvarchar(100), 
	@id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.Teams(TeamName)
		values(@TeamName);
	select @id = SCOPE_IDENTITY();


end
GO
/****** Object:  StoredProcedure [dbo].[spTournamentEntries_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournamentEntries_Insert]
	@TournamentId int, 
	@TeamId int,
	@Id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.TournamentEntries(TournamentId, TeamId)
		values(@TournamentId,@TeamId); 

	Select @Id = SCOPE_IDENTITY();

end
GO
/****** Object:  StoredProcedure [dbo].[spTournamentPrizes_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournamentPrizes_Insert]
	@TournamentId int, 
	@PrizeId int,
	@Id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.TournamentPrizes(TournamentId, PrizeId)
		values(@TournamentId,@PrizeId); 

	Select @Id = SCOPE_IDENTITY();

end
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_Complete]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournaments_Complete]
	@Id int 
AS
begin
	set nocount on;

	update dbo.Tournaments 
	set  Active = 0
	where id = @Id;	

end
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_GetAll]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournaments_GetAll]
	 
AS
begin
	set nocount on;
	 select * from dbo.Tournaments where Active = 1;

end
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_Insert]    Script Date: 5/24/2022 7:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTournaments_Insert]
	@TournamentName nvarchar(200), 
	@EntryFee money,
	@Id int = 0 output
AS
begin
	set nocount on;
	Insert into dbo.Tournaments(TournamentName,EntryFee,Active)
		values(@TournamentName,@EntryFee,1); 

		select @Id = SCOPE_IDENTITY();
end
GO
