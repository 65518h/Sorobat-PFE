Table 70101 "Imp Salesperson/Purchaser"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Commission %"; Decimal)
        {
        }
        field(5050; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(5051; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(5052; "E-Mail"; Text[80])
        {
        }
        field(5053; "Phone No."; Text[30])
        {
        }
        field(5054; "Next To-do Date"; Date)
        {
        }
        field(5055; "No. of Opportunities"; Integer)
        {
        }
        field(5056; "Estimated Value (LCY)"; Decimal)
        {
        }
        field(5057; "Calcd. Current Value (LCY)"; Decimal)
        {
        }
        field(5058; "Date Filter"; Date)
        {
        }
        field(5059; "No. of Interactions"; Integer)
        {
        }
        field(5060; "Cost (LCY)"; Decimal)
        {
        }
        field(5061; "Duration (Min.)"; Decimal)
        {
        }
        field(5062; "Job Title"; Text[30])
        {
        }
        field(5063; "Action Taken Filter"; Option)
        {
            OptionMembers = ,Next,Previous,Updated,Jumped,Won,Lost;
        }
        field(5064; "Sales Cycle Filter"; Code[10])
        {
        }
        field(5065; "Sales Cycle Stage Filter"; Integer)
        {
        }
        field(5066; "Probability % Filter"; Decimal)
        {
        }
        field(5067; "Completed % Filter"; Decimal)
        {
        }
        field(5068; "Avg. Estimated Value (LCY)"; Decimal)
        {
        }
        field(5069; "Avg.Calcd. Current Value (LCY)"; Decimal)
        {
        }
        field(5070; "Contact Filter"; Code[20])
        {
        }
        field(5071; "Contact Company Filter"; Code[20])
        {
        }
        field(5072; "Campaign Filter"; Code[20])
        {
        }
        field(5073; "Estimated Value Filter"; Decimal)
        {
        }
        field(5074; "Calcd. Current Value Filter"; Decimal)
        {
        }
        field(5075; "Chances of Success % Filter"; Decimal)
        {
        }
        field(5076; "To-do Status Filter"; Option)
        {
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;
        }
        field(5077; "Closed To-do Filter"; Boolean)
        {
        }
        field(5078; "Priority Filter"; Option)
        {
            OptionMembers = Low,Normal,High;
        }
        field(5079; "Team Filter"; Code[10])
        {
        }
        field(5082; "Opportunity Entry Exists"; Boolean)
        {
        }
        field(5083; "To-do Entry Exists"; Boolean)
        {
        }
        field(5084; "Close Opportunity Filter"; Code[10])
        {
        }
        field(5085; "Search E-Mail"; Code[80])
        {
        }
        field(5086; "Outlook Contacts Folder Path"; Text[250])
        {
        }
        field(5087; "Outlook Tasks Folder Path"; Text[250])
        {
        }
        field(5088; "Outlook Calendar Folder Path"; Text[250])
        {
        }
        field(5089; "Navision User ID"; Code[20])
        {
        }
        field(5090; "Outlook User Name"; Text[80])
        {
        }
        field(5091; "Enable Synchronization"; Boolean)
        {
        }
        field(5092; "Outlook Profile Name"; Text[80])
        {
        }
        field(5093; "Outlook Contacts FolderID"; Blob)
        {
        }
        field(5094; "Outlook Tasks FolderID"; Blob)
        {
        }
        field(5095; "Outlook Calendar FolderID"; Blob)
        {
        }
        field(5096; "Outlook Contacts StoreID"; Blob)
        {
        }
        field(5097; "Outlook Tasks StoreID"; Blob)
        {
        }
        field(5098; "Outlook Calendar StoreID"; Blob)
        {
        }
        field(5100; "Notify about Contact Changes"; Boolean)
        {
        }
        field(5101; "Notify about Task Changes"; Boolean)
        {
        }
        field(5102; "Notify about Appmt. Changes"; Boolean)
        {
        }
        field(5103; "Synchronize From"; DateFormula)
        {
        }
        field(5104; "Synchronize To"; DateFormula)
        {
        }
        field(5105; "Synchronize To-dos"; Option)
        {
            OptionMembers = All,"Time Period";
        }
        field(5106; "Version No."; Integer)
        {
        }
        field(5107; "Notify about Team To-do Chgs."; Boolean)
        {
        }
        field(5108; "No. of Errors and Warnings"; Integer)
        {
        }
        field(5109; "No. of Conflicts"; Integer)
        {
        }
        field(5110; "No. of Unsynchd. Categories"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

