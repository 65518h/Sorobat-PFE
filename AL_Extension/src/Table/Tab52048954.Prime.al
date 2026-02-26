table 52048954 Prime
{ //GL2024  ID dans Nav 2009 : "39001450"
  // DrillDownPageID = Prime;
  //   LookupPageID = Prime;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Designation; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = " ","Fin D'année",Trimestriel,semestrielle;
        }
        field(4; "Type Calcul"; Option)
        {
            OptionMembers = "Prime=(SB*Note net)*(1-Abs net/360)*(1-Sanct)","Prime=(somme SB Brut* 26 *(J TR/360)/(24*M TR))- (SB Brut12*(M TR/12))","Prime=(somme SB Brut* 26)/JTRAVAN)*Taux)";
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

