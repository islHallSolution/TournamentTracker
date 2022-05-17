using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreateTournamentForm : Form, IPrizeRequester, ITeamRequester
    {
        List<TeamModel> avaliableTeams = GlobalConfig.Connection.GetAllTeam();
        List<TeamModel> selectedTeams = new List<TeamModel>();
        List<PrizeModel> selectedPrizes = new List<PrizeModel>();
        public CreateTournamentForm()
        {
            InitializeComponent();
            wireUplist();
        }

        private void wireUplist()
        {
            SelectTeamDropDown.DataSource = null;
            SelectTeamDropDown.DataSource = avaliableTeams;
            SelectTeamDropDown.DisplayMember = "TeamName";

            tournamentTeamsListBox.DataSource = null;
            tournamentTeamsListBox.DataSource = selectedTeams;
            tournamentTeamsListBox.DisplayMember = "TeamName";

            prizesListBox.DataSource = null;
            prizesListBox.DataSource = selectedPrizes;
            prizesListBox.DisplayMember = "PlaceName";
        }

        private void addTeamButton_Click(object sender, EventArgs e)
        {

            TeamModel t = (TeamModel)SelectTeamDropDown.SelectedItem;
            if (t != null)
            {
                avaliableTeams.Remove(t);
                selectedTeams.Add(t);

                wireUplist();

            }

        }

        private void createPrizeButton_Click(object sender, EventArgs e)
        {
            //TODO call the createPrizeForm
            CreatePrizeForm frm = new CreatePrizeForm(this);
            frm.Show();

        }

        public void PrizeComplete(PrizeModel model)
        {
            selectedPrizes.Add(model);
            wireUplist();
        }

        public void TeamComplete(TeamModel model)
        {
            selectedTeams.Add(model);
            wireUplist();
        }

        private void createNewTeamLink_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            CreateTeamForm frm = new CreateTeamForm(this);
            frm.Show();
        }

        private void removeSelectedPlayerButton_Click(object sender, EventArgs e)
        {
            TeamModel t = (TeamModel)tournamentTeamsListBox.SelectedItem;
            if (t != null)
            {
                selectedTeams.Remove(t);
                avaliableTeams.Add(t);
                wireUplist();
            }

        }

        private void removeSelectdPrizeButton_Click(object sender, EventArgs e)
        {
            PrizeModel t = (PrizeModel)prizesListBox.SelectedItem;
            if (t != null)
            {
                selectedPrizes.Remove(t);

                wireUplist();
            }
        }

        private void createTournamentButton_Click(object sender, EventArgs e)
        {
            decimal fee = 0;

            bool feeAcceptable = decimal.TryParse(entryFeeValue.Text, out fee);

            if (!feeAcceptable)
            {
                MessageBox.Show("You need to enter a valid Entry Fee.",
                    "Invalid Fee",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
                return;
            }
            TournamentModel tm = new TournamentModel();

            tm.TournamentName = tournamentNameValue.Text;
            tm.EntryFee = fee;

            tm.Prizes = selectedPrizes;             
            tm.EnteredTeams = selectedTeams;

            TournamentLogic.CreateRounds(tm);

            GlobalConfig.Connection.CreateTournament(tm);


        }
    }
}
