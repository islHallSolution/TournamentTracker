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
    public partial class TournamentViewerForm : Form
    {
        private TournamentModel tournament;

        BindingList<int> rounds = new BindingList<int>();
        BindingList<MatchupModel> selectedmatchups = new BindingList<MatchupModel>();


        public TournamentViewerForm(TournamentModel tournamentModel)
        {
            InitializeComponent();

            tournament = tournamentModel;

            WireUpLists();

            LoadFormData();

            LoadRounds();
        }

        private void LoadFormData()
        {
            TournamentName.Text = tournament.TournamentName;
        }
        private void LoadRounds()
        {
            rounds.Clear();
            rounds.Add(1);
            int currRound = 1;

            foreach (List<MatchupModel> matchups in tournament.Rounds)
            {

                if (matchups.First().MatchupRound > currRound)
                {
                    currRound = matchups.First().MatchupRound;
                    rounds.Add(currRound);

                }
            }

            LoadMatchups(1);
        }

        private void WireUpLists()
        {
            roundDropDown.DataSource = rounds;

            matchuplistBox.DataSource = selectedmatchups;
            matchuplistBox.DisplayMember = "DisplayName";
        }
        private void roundDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMatchups((int)roundDropDown.SelectedItem);
        }

        private void LoadMatchups(int round)
        {

            foreach (List<MatchupModel> matchups in tournament.Rounds)
            {

                if (matchups.First().MatchupRound == round)
                {
                    selectedmatchups.Clear();
                    foreach (MatchupModel m in matchups)
                    {
                        if (m.Winner == null || !unplayedOnlycheckBox.Checked)
                        {
                            selectedmatchups.Add(m);
                        }
                    }
                }
            }
            if (selectedmatchups.Count > 0)
            {
                LoadMatchup(selectedmatchups.First());
            }
            DisplayMatchupInfo();
        }
        private void DisplayMatchupInfo()
        {
            bool isVisible = (selectedmatchups.Count > 0);

            TeamOneName.Visible = isVisible;
            teamOneScoreLabel.Visible = isVisible;
            teamOneScoreValue.Visible = isVisible;
            teamTwoName.Visible = isVisible;
            teamTwoScoreLabel.Visible = isVisible;
            teamTwoScoreValue.Visible = isVisible;
            VersusLabel.Visible = isVisible;
            scoreButton.Visible = isVisible;

        }

        private void LoadMatchup(MatchupModel m)
        {

            for (int i = 0; i < m.Entries.Count; i++)
            {
                if (i == 0)
                {
                    if (m.Entries[0].TeamCompeting != null)
                    {
                        TeamOneName.Text = m.Entries[0].TeamCompeting.TeamName;
                        teamOneScoreValue.Text = m.Entries[0].Score.ToString();


                        teamTwoName.Text = "<bye>";
                        teamTwoScoreValue.Text = "0";
                    }
                    else
                    {
                        TeamOneName.Text = "Not yet set";
                        teamOneScoreValue.Text = "";
                    }
                }
                if (i == 1)
                {
                    if (m.Entries[1].TeamCompeting != null)
                    {
                        teamTwoName.Text = m.Entries[1].TeamCompeting.TeamName;
                        teamTwoScoreValue.Text = m.Entries[1].Score.ToString();
                    }
                    else
                    {
                        teamTwoName.Text = "Not yet set";
                        teamTwoScoreValue.Text = "";
                    }
                }
            }
        }

        private void matchuplistBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (matchuplistBox.SelectedItem != null)
            {
                LoadMatchup((MatchupModel)matchuplistBox.SelectedItem);
            }
        }

        private void unplayedOnlycheckBox_CheckedChanged(object sender, EventArgs e)
        {
            LoadMatchups((int)roundDropDown.SelectedItem);
        }

        private void scoreButton_Click(object sender, EventArgs e)
        {
            MatchupModel m = (MatchupModel)matchuplistBox.SelectedItem;
            double teamOneScore = 0;
            double teamTwoScore = 0;
            for (int i = 0; i < m.Entries.Count; i++)
            {
                if (i == 0)
                {
                    if (m.Entries[0].TeamCompeting != null)
                    {
                        bool scoreValid = double.TryParse(teamOneScoreValue.Text, out teamOneScore);
                        if (scoreValid)
                        {
                            m.Entries[0].Score = teamOneScore;
                        }
                        else
                        {
                            MessageBox.Show("Please enter a valid score for team 1.");
                            return;
                        }

                    }
                }
                if (i == 1)
                {
                    if (m.Entries[1].TeamCompeting != null)
                    {
                        bool scoreValid = double.TryParse(teamTwoScoreValue.Text, out teamTwoScore);
                        if (scoreValid)
                        {
                            m.Entries[1].Score = teamTwoScore;
                        }
                        else
                        {
                            MessageBox.Show("Please enter a valid score for team 2.");
                            return;
                        }
                    }
                }
            }
            if (teamOneScore > teamTwoScore)
            {
                m.Winner = m.Entries[0].TeamCompeting;
            }
            else if (teamTwoScore > teamOneScore)
            {
                m.Winner = m.Entries[1].TeamCompeting;
            }
            else
            {
                MessageBox.Show("I do not handle tie games.");
            }
            //regra dos matchupEntries https://youtu.be/wfWxdh-_k_4?t=72545

            foreach (List<MatchupModel> round in tournament.Rounds)
            {
                foreach (MatchupModel rm in round)
                {
                    foreach (MatchupEntryModel me in rm.Entries)
                    {
                        if (me.ParentMatchup != null)
                        {
                            if (me.ParentMatchup.Id == m.Id)
                            {
                                me.TeamCompeting = m.Winner;
                                GlobalConfig.Connection.UpdateMatchup(rm);
                            }
                        }
                    }
                }
            }

            LoadMatchups((int)roundDropDown.SelectedItem);

            GlobalConfig.Connection.UpdateMatchup(m);
        }
    }
}