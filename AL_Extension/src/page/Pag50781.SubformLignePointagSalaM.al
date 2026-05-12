Page 50781 "Subform Ligne Pointag Sala M"
{
    PageType = ListPart;
    SourceTable = "Ligne Pointage Salarier Man";
    ApplicationArea = all;
    Caption = 'Subform Ligne Pointage Salarier Manuelle';
    // InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                FreezeColumn = Affectation;
                field("N°"; Rec."N°")
                {
                    ToolTip = 'Specifies the value of the N° field.', Comment = '%';
                    Visible = false;

                }

                field(Matricule; Rec.Matricule)
                {
                    ToolTip = 'Specifies the value of the Matricule field.', Comment = '%';
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field(Nom; Rec.Nom)
                {
                    ToolTip = 'Specifies the value of the Nom field.', Comment = '%';
                    Style = Strong;
                    StyleExpr = TRUE;

                }

                field(Affectation; Rec.Affectation)
                {
                    ToolTip = 'Specifies the value of the Affectation field.', Comment = '%';
                }
                /*field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.', Comment = '%';
                }*/
                field("Description Affectation"; Rec."Description Affectation")
                {
                    ToolTip = 'Specifies the value of the Description Affectation field.', Comment = '%';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Description Qualification"; Rec."Description Qualification")
                {
                    ToolTip = 'Specifies the value of the Description Qualification field.', Comment = '%';
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("1"; Rec."1")
                {
                    ToolTip = 'Specifies the value of the 1 field.', Comment = '%';
                    Editable = EDITABLE1;
                    StyleExpr = GetStyleForStatus1;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE1 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."1", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("2"; Rec."2")
                {
                    ToolTip = 'Specifies the value of the 2 field.', Comment = '%';
                    Editable = EDITABLE2;
                    StyleExpr = GetStyleForStatus2;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE2 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."2", RecCondition.Code);
                        END;

                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("3"; Rec."3")
                {
                    ToolTip = 'Specifies the value of the 3 field.', Comment = '%';
                    Editable = EDITABLE3;
                    StyleExpr = GetStyleForStatus3;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE3 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."3", RecCondition.Code);
                        end;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("4"; Rec."4")
                {
                    ToolTip = 'Specifies the value of the 4 field.', Comment = '%';
                    Editable = EDITABLE4;
                    StyleExpr = GetStyleForStatus4;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE4 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."4", RecCondition.Code);
                        end;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("5"; Rec."5")
                {
                    ToolTip = 'Specifies the value of the 5 field.', Comment = '%';
                    Editable = EDITABLE5;
                    StyleExpr = GetStyleForStatus5;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE5 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."5", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("6"; Rec."6")
                {
                    ToolTip = 'Specifies the value of the 6 field.', Comment = '%';
                    Editable = EDITABLE6;
                    StyleExpr = GetStyleForStatus6;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE6 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."6", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("7"; Rec."7")
                {
                    ToolTip = 'Specifies the value of the 7 field.', Comment = '%';
                    Editable = EDITABLE7;
                    StyleExpr = GetStyleForStatus7;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE7 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."7", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("8"; Rec."8")
                {
                    ToolTip = 'Specifies the value of the 8 field.', Comment = '%';
                    Editable = EDITABLE8;
                    StyleExpr = GetStyleForStatus8;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE8 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."8", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("9"; Rec."9")
                {
                    ToolTip = 'Specifies the value of the 9 field.', Comment = '%';
                    Editable = EDITABLE9;
                    StyleExpr = GetStyleForStatus9;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE9 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."9", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("10"; Rec."10")
                {
                    ToolTip = 'Specifies the value of the 10 field.', Comment = '%';
                    Editable = EDITABLE10;
                    StyleExpr = GetStyleForStatus10;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE10 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."10", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("11"; Rec."11")
                {
                    ToolTip = 'Specifies the value of the 11 field.', Comment = '%';
                    Editable = EDITABLE11;
                    StyleExpr = GetStyleForStatus11;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE11 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."11", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("12"; Rec."12")
                {
                    ToolTip = 'Specifies the value of the 12 field.', Comment = '%';
                    Editable = EDITABLE12;
                    StyleExpr = GetStyleForStatus12;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE12 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."12", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("13"; Rec."13")
                {
                    ToolTip = 'Specifies the value of the 13 field.', Comment = '%';
                    Editable = EDITABLE13;
                    StyleExpr = GetStyleForStatus13;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE13 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."13", RecCondition.Code);
                        END;

                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("14"; Rec."14")
                {
                    ToolTip = 'Specifies the value of the 14 field.', Comment = '%';
                    Editable = EDITABLE14;
                    StyleExpr = GetStyleForStatus14;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE14 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                rec.validate(Rec."14", RecCondition.Code);
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("15"; Rec."15")
                {
                    ToolTip = 'Specifies the value of the 15 field.', Comment = '%';
                    Editable = EDITABLE15;
                    StyleExpr = GetStyleForStatus15;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE15 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."15" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("16"; Rec."16")
                {
                    ToolTip = 'Specifies the value of the 16 field.', Comment = '%';
                    Editable = EDITABLE16;
                    StyleExpr = GetStyleForStatus16;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE16 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."16" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("17"; Rec."17")
                {
                    ToolTip = 'Specifies the value of the 17 field.', Comment = '%';
                    Editable = EDITABLE17;
                    StyleExpr = GetStyleForStatus17;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE17 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."17" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("18"; Rec."18")
                {
                    ToolTip = 'Specifies the value of the 18 field.', Comment = '%';
                    Editable = EDITABLE18;
                    StyleExpr = GetStyleForStatus18;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE18 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."18" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("19"; Rec."19")
                {
                    ToolTip = 'Specifies the value of the 19 field.', Comment = '%';
                    Editable = EDITABLE19;
                    StyleExpr = GetStyleForStatus19;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE19 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."19" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("20"; Rec."20")
                {
                    ToolTip = 'Specifies the value of the 20 field.', Comment = '%';
                    Editable = EDITABLE20;
                    StyleExpr = GetStyleForStatus20;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE20 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."20" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("21"; Rec."21")
                {
                    ToolTip = 'Specifies the value of the 21 field.', Comment = '%';
                    Editable = EDITABLE21;
                    StyleExpr = GetStyleForStatus21;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE21 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."21" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("22"; Rec."22")
                {
                    ToolTip = 'Specifies the value of the 22 field.', Comment = '%';
                    Editable = EDITABLE22;
                    StyleExpr = GetStyleForStatus22;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE22 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."22" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("23"; Rec."23")
                {
                    ToolTip = 'Specifies the value of the 23 field.', Comment = '%';
                    Editable = EDITABLE23;
                    StyleExpr = GetStyleForStatus23;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE23 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."23" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("24"; Rec."24")
                {
                    ToolTip = 'Specifies the value of the 24 field.', Comment = '%';
                    Editable = EDITABLE24;
                    StyleExpr = GetStyleForStatus24;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE24 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."24" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("25"; Rec."25")
                {
                    ToolTip = 'Specifies the value of the 25 field.', Comment = '%';
                    Editable = EDITABLE25;
                    StyleExpr = GetStyleForStatus25;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE25 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."25" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("26"; Rec."26")
                {
                    ToolTip = 'Specifies the value of the 26 field.', Comment = '%';
                    Editable = EDITABLE26;
                    StyleExpr = GetStyleForStatus26;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE26 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."26" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("27"; Rec."27")
                {
                    ToolTip = 'Specifies the value of the 27 field.', Comment = '%';
                    Editable = EDITABLE27;
                    StyleExpr = GetStyleForStatus27;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE27 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."27" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("28"; Rec."28")
                {
                    ToolTip = 'Specifies the value of the 28 field.', Comment = '%';
                    Editable = EDITABLE28;
                    StyleExpr = GetStyleForStatus28;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE28 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."28" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("29"; Rec."29")
                {
                    ToolTip = 'Specifies the value of the 29 field.', Comment = '%';
                    Editable = EDITABLE29;
                    StyleExpr = GetStyleForStatus29;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE29 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."29" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("30"; Rec."30")
                {
                    ToolTip = 'Specifies the value of the 30 field.', Comment = '%';
                    Editable = EDITABLE30;
                    StyleExpr = GetStyleForStatus30;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE30 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."30" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("31"; Rec."31")
                {
                    ToolTip = 'Specifies the value of the 31 field.', Comment = '%';
                    Editable = EDITABLE31;
                    StyleExpr = GetStyleForStatus31;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        RecCondition: Record "Condition de Pointage";
                    begin
                        IF EDITABLE31 = TRUE THEN BEGIN
                            if Page.RunModal(Page::"Liste Condition de Pointage", RecCondition) = Action::LookupOK then
                                Rec."31" := RecCondition.Code;
                        END;
                    end;

                    trigger OnValidate()
                    var

                    begin
                        Presence()
                    end;
                }
                field("Nbre Jours Present"; Rec."Nbre Jours Present")
                {
                    ToolTip = 'Specifies the value of the Nbre Jours Present field.', Comment = '%';
                    Style = Favorable;
                    StyleExpr = TRUE;

                }
                field("Nbre Jours Absent"; Rec."Nbre Jours Absent")
                {
                    ToolTip = 'Specifies the value of the Nbre Jours Absent field.', Comment = '%';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Nbre Total Heures Presnt"; Rec."Nbre Total Heures Presnt")
                {
                    ToolTip = 'Specifies the value of the Nbre Total Heures Presnt field.', Comment = '%';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Taux d'absenteisme"; Rec."Taux d'absenteisme")
                {
                    ToolTip = 'Specifies the value of the Taux d''absenteisme field.', Comment = '%';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Nbre Jours Congé"; Rec."Nbre Jours Congé")
                {
                    ToolTip = 'Specifies the value of the Nbre Jours Congé field.', Comment = '%';
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Nbre Jours Congé EXP"; Rec."Nbre Jours Congé EXP")
                {
                    ToolTip = 'Specifies the value of the Nbre Jours Congé EXP field.', Comment = '%';
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Nbre Jours Ferier"; Rec."Nbre Jours Ferier")
                {
                    ToolTip = 'Specifies the value of the Nbre Jours Ferier field.', Comment = '%';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }




            }
        }
    }


    actions
    {
        area(processing)
        {


        }
    }

    procedure Presence()
    var
        JoursPres: Decimal;
        JoursCongé: Decimal;
        JoursABS: Integer;
        JoursFérié: Integer;
        JoursCongéEXP: Decimal;
        TotalHeurePre: Decimal;
        MaChaine: Text;
        MonDecimal: Decimal;
        JoursPointage: Integer;
    begin
        JoursPres := 0;
        JoursCongé := 0;
        JoursFérié := 0;
        JoursABS := 0;
        JoursCongéEXP := 0;
        TotalHeurePre := 0;
        JoursPointage := 0;


        //************** "1" ****************
        MaChaine := Rec."1";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."1" = 'P') OR (Rec."1" = 'AU') OR (Rec."1" = 'P-R') OR (Rec."1" = 'MISS') OR (Rec."1" = 'FOR') THEN JoursPres += 1;
            IF (Rec."1" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."1" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."1" = 'A') THEN JoursABS += 1;
            IF (Rec."1" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."1" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;

        END;

        //************** "1" ****************

        //************** "2" ****************
        MaChaine := Rec."2";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."2" = 'P') OR (Rec."2" = 'AU') OR (Rec."2" = 'P-R') OR (Rec."2" = 'MISS') OR (Rec."2" = 'FOR') THEN JoursPres += 1;
            IF (Rec."2" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."2" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."2" = 'A') THEN JoursABS += 1;
            IF (Rec."2" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."2" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;

        END;
        //************** "2" ****************

        //************** "3" ****************
        MaChaine := Rec."3";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."3" = 'P') OR (Rec."3" = 'AU') OR (Rec."3" = 'P-R') OR (Rec."3" = 'MISS') OR (Rec."3" = 'FOR') THEN JoursPres += 1;
            IF (Rec."3" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."3" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."3" = 'A') THEN JoursABS += 1;
            IF (Rec."3" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."3" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "3" ****************

        //************** "4" ****************
        MaChaine := Rec."4";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."4" = 'P') OR (Rec."4" = 'AU') OR (Rec."4" = 'P-R') OR (Rec."4" = 'MISS') OR (Rec."4" = 'FOR') THEN JoursPres += 1;
            IF (Rec."4" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."4" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."4" = 'A') THEN JoursABS += 1;
            IF (Rec."4" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."4" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "4" ****************

        //************** "5" ****************
        MaChaine := Rec."5";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."5" = 'P') OR (Rec."5" = 'AU') OR (Rec."5" = 'P-R') OR (Rec."5" = 'MISS') OR (Rec."5" = 'FOR') THEN JoursPres += 1;
            IF (Rec."5" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."5" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."5" = 'A') THEN JoursABS += 1;
            IF (Rec."5" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."5" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "5" ****************

        //************** "6" ****************
        MaChaine := Rec."6";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."6" = 'P') OR (Rec."6" = 'AU') OR (Rec."6" = 'P-R') OR (Rec."6" = 'MISS') OR (Rec."6" = 'FOR') THEN JoursPres += 1;
            IF (Rec."6" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."6" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."6" = 'A') THEN JoursABS += 1;
            IF (Rec."6" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."6" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "6" ****************

        //************** "7" ****************
        MaChaine := Rec."7";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."7" = 'P') OR (Rec."7" = 'AU') OR (Rec."7" = 'P-R') OR (Rec."7" = 'MISS') OR (Rec."7" = 'FOR') THEN JoursPres += 1;
            IF (Rec."7" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."7" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."7" = 'A') THEN JoursABS += 1;
            IF (Rec."7" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."7" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "7" ****************

        //************** "8" ****************
        MaChaine := Rec."8";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."8" = 'P') OR (Rec."8" = 'AU') OR (Rec."8" = 'P-R') OR (Rec."8" = 'MISS') OR (Rec."8" = 'FOR') THEN JoursPres += 1;
            IF (Rec."8" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."8" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."8" = 'A') THEN JoursABS += 1;
            IF (Rec."8" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."8" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "8" ****************

        //************** "9" ****************
        MaChaine := Rec."9";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."9" = 'P') OR (Rec."9" = 'AU') OR (Rec."9" = 'P-R') OR (Rec."9" = 'MISS') OR (Rec."9" = 'FOR') THEN JoursPres += 1;
            IF (Rec."9" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."9" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."9" = 'A') THEN JoursABS += 1;
            IF (Rec."9" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."9" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "9" ****************

        //************** "10" ****************
        MaChaine := Rec."10";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."10" = 'P') OR (Rec."10" = 'AU') OR (Rec."10" = 'P-R') OR (Rec."10" = 'MISS') OR (Rec."10" = 'FOR') THEN JoursPres += 1;
            IF (Rec."10" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."10" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."10" = 'A') THEN JoursABS += 1;
            IF (Rec."10" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."10" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "10" ****************

        //************** "11" ****************
        MaChaine := Rec."11";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."11" = 'P') OR (Rec."11" = 'AU') OR (Rec."11" = 'P-R') OR (Rec."11" = 'MISS') OR (Rec."11" = 'FOR') THEN JoursPres += 1;
            IF (Rec."11" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."11" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."11" = 'A') THEN JoursABS += 1;
            IF (Rec."11" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."11" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "11" ****************

        //************** "12" ****************
        MaChaine := Rec."12";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."12" = 'P') OR (Rec."12" = 'AU') OR (Rec."12" = 'P-R') OR (Rec."12" = 'MISS') OR (Rec."12" = 'FOR') THEN JoursPres += 1;
            IF (Rec."12" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."12" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."12" = 'A') THEN JoursABS += 1;
            IF (Rec."12" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."12" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "12" ****************

        //************** "13" ****************
        MaChaine := Rec."13";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."13" = 'P') OR (Rec."13" = 'AU') OR (Rec."13" = 'P-R') OR (Rec."13" = 'MISS') OR (Rec."13" = 'FOR') THEN JoursPres += 1;
            IF (Rec."13" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."13" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."13" = 'A') THEN JoursABS += 1;
            IF (Rec."13" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."13" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "13" ****************

        //************** "14" ****************
        MaChaine := Rec."14";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."14" = 'P') OR (Rec."14" = 'AU') OR (Rec."14" = 'P-R') OR (Rec."14" = 'MISS') OR (Rec."14" = 'FOR') THEN JoursPres += 1;
            IF (Rec."14" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."14" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."14" = 'A') THEN JoursABS += 1;
            IF (Rec."14" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."14" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "14" ****************

        //************** "15" ****************
        MaChaine := Rec."15";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."15" = 'P') OR (Rec."15" = 'AU') OR (Rec."15" = 'P-R') OR (Rec."15" = 'MISS') OR (Rec."15" = 'FOR') THEN JoursPres += 1;
            IF (Rec."15" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."15" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."15" = 'A') THEN JoursABS += 1;
            IF (Rec."15" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."15" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "15" ****************

        //************** "16" ****************
        MaChaine := Rec."16";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."16" = 'P') OR (Rec."16" = 'AU') OR (Rec."16" = 'P-R') OR (Rec."16" = 'MISS') OR (Rec."16" = 'FOR') THEN JoursPres += 1;
            IF (Rec."16" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."16" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."16" = 'A') THEN JoursABS += 1;
            IF (Rec."16" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."16" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "16" ****************

        //************** "17" ****************
        MaChaine := Rec."17";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."17" = 'P') OR (Rec."17" = 'AU') OR (Rec."17" = 'P-R') OR (Rec."17" = 'MISS') OR (Rec."17" = 'FOR') THEN JoursPres += 1;
            IF (Rec."17" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."17" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."17" = 'A') THEN JoursABS += 1;
            IF (Rec."17" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."17" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "17" ****************

        //************** "18" ****************
        MaChaine := Rec."18";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."18" = 'P') OR (Rec."18" = 'AU') OR (Rec."18" = 'P-R') OR (Rec."18" = 'MISS') OR (Rec."18" = 'FOR') THEN JoursPres += 1;
            IF (Rec."18" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."18" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."18" = 'A') THEN JoursABS += 1;
            IF (Rec."18" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."18" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "18" ****************

        //************** "19" ****************
        MaChaine := Rec."19";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."19" = 'P') OR (Rec."19" = 'AU') OR (Rec."19" = 'P-R') OR (Rec."19" = 'MISS') OR (Rec."19" = 'FOR') THEN JoursPres += 1;
            IF (Rec."19" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."19" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."19" = 'A') THEN JoursABS += 1;
            IF (Rec."19" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."19" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "19" ****************

        //************** "20" ****************
        MaChaine := Rec."20";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."20" = 'P') OR (Rec."20" = 'AU') OR (Rec."20" = 'P-R') OR (Rec."20" = 'MISS') OR (Rec."20" = 'FOR') THEN JoursPres += 1;
            IF (Rec."20" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."20" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."20" = 'A') THEN JoursABS += 1;
            IF (Rec."20" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."20" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "20" ****************

        //************** "21" ****************
        MaChaine := Rec."21";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."21" = 'P') OR (Rec."21" = 'AU') OR (Rec."21" = 'P-R') OR (Rec."21" = 'MISS') OR (Rec."21" = 'FOR') THEN JoursPres += 1;
            IF (Rec."21" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."21" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."21" = 'A') THEN JoursABS += 1;
            IF (Rec."21" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."21" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "21" ****************

        //************** "22" ****************
        MaChaine := Rec."22";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."22" = 'P') OR (Rec."22" = 'AU') OR (Rec."22" = 'P-R') OR (Rec."22" = 'MISS') OR (Rec."22" = 'FOR') THEN JoursPres += 1;
            IF (Rec."22" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."22" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."22" = 'A') THEN JoursABS += 1;
            IF (Rec."22" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."22" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "22" ****************

        //************** "23" ****************
        MaChaine := Rec."23";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."23" = 'P') OR (Rec."23" = 'AU') OR (Rec."23" = 'P-R') OR (Rec."23" = 'MISS') OR (Rec."23" = 'FOR') THEN JoursPres += 1;
            IF (Rec."23" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."23" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."23" = 'A') THEN JoursABS += 1;
            IF (Rec."23" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."23" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "23" ****************

        //************** "24" ****************
        MaChaine := Rec."24";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."24" = 'P') OR (Rec."24" = 'AU') OR (Rec."24" = 'P-R') OR (Rec."24" = 'MISS') OR (Rec."24" = 'FOR') THEN JoursPres += 1;
            IF (Rec."24" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."24" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."24" = 'A') THEN JoursABS += 1;
            IF (Rec."24" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."24" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "24" ****************

        //************** "25" ****************
        MaChaine := Rec."25";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."25" = 'P') OR (Rec."25" = 'AU') OR (Rec."25" = 'P-R') OR (Rec."25" = 'MISS') OR (Rec."25" = 'FOR') THEN JoursPres += 1;
            IF (Rec."25" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."25" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."25" = 'A') THEN JoursABS += 1;
            IF (Rec."25" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."25" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "25" ****************

        //************** "26" ****************
        MaChaine := Rec."26";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."26" = 'P') OR (Rec."26" = 'AU') OR (Rec."26" = 'P-R') OR (Rec."26" = 'MISS') OR (Rec."26" = 'FOR') THEN JoursPres += 1;
            IF (Rec."26" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."26" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."26" = 'A') THEN JoursABS += 1;
            IF (Rec."26" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."26" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "26" ****************

        //************** "27" ****************
        MaChaine := Rec."27";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."27" = 'P') OR (Rec."27" = 'AU') OR (Rec."27" = 'P-R') OR (Rec."27" = 'MISS') OR (Rec."27" = 'FOR') THEN JoursPres += 1;
            IF (Rec."27" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."27" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."27" = 'A') THEN JoursABS += 1;
            IF (Rec."27" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."27" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "27" ****************

        //************** "28" ****************
        MaChaine := Rec."28";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."28" = 'P') OR (Rec."28" = 'AU') OR (Rec."28" = 'P-R') OR (Rec."28" = 'MISS') OR (Rec."28" = 'FOR') THEN JoursPres += 1;
            IF (Rec."28" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."28" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."28" = 'A') THEN JoursABS += 1;
            IF (Rec."28" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."28" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "28" ****************

        //************** "29" ****************
        MaChaine := Rec."29";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."29" = 'P') OR (Rec."29" = 'AU') OR (Rec."29" = 'P-R') OR (Rec."29" = 'MISS') OR (Rec."29" = 'FOR') THEN JoursPres += 1;
            IF (Rec."29" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."29" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."29" = 'A') THEN JoursABS += 1;
            IF (Rec."29" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."29" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "29" ****************

        //************** "30" ****************
        MaChaine := Rec."30";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."30" = 'P') OR (Rec."30" = 'AU') OR (Rec."30" = 'P-R') OR (Rec."30" = 'MISS') OR (Rec."30" = 'FOR') THEN JoursPres += 1;
            IF (Rec."30" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."30" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."30" = 'A') THEN JoursABS += 1;
            IF (Rec."30" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."30" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "30" ****************

        //************** "31" ****************
        MaChaine := Rec."31";
        IF Evaluate(MonDecimal, MaChaine) THEN BEGIN
            IF MonDecimal > 0 THEN JoursPres += 1;
            TotalHeurePre += MonDecimal;
        END
        ELSE BEGIN
            IF (Rec."31" = 'P') OR (Rec."31" = 'AU') OR (Rec."31" = 'P-R') OR (Rec."31" = 'MISS') OR (Rec."31" = 'FOR') THEN JoursPres += 1;
            IF (Rec."31" = 'C') THEN "JoursCongé" += 1;
            IF (Rec."31" = 'F') THEN "JoursFérié" += 1;
            IF (Rec."31" = 'A') THEN JoursABS += 1;
            IF (Rec."31" = 'CEXP') THEN JoursCongéEXP += 1;
            IF (Rec."31" = 'C1/2') THEN begin
                "JoursCongé" += 0.5;
                JoursPres += 0.5
            end;
        END;
        //************** "31" ****************
        IF (Rec."1" <> '.') AND (Rec."1" <> '') AND (Rec."1" <> 'X') THEN JoursPointage += 1;
        IF (Rec."2" <> '.') AND (Rec."2" <> '') AND (Rec."2" <> 'X') THEN JoursPointage += 1;
        IF (Rec."3" <> '.') AND (Rec."3" <> '') AND (Rec."3" <> 'X') THEN JoursPointage += 1;
        IF (Rec."4" <> '.') AND (Rec."4" <> '') AND (Rec."4" <> 'X') THEN JoursPointage += 1;
        IF (Rec."5" <> '.') AND (Rec."5" <> '') AND (Rec."5" <> 'X') THEN JoursPointage += 1;
        IF (Rec."6" <> '.') AND (Rec."6" <> '') AND (Rec."6" <> 'X') THEN JoursPointage += 1;
        IF (Rec."7" <> '.') AND (Rec."7" <> '') AND (Rec."7" <> 'X') THEN JoursPointage += 1;
        IF (Rec."8" <> '.') AND (Rec."8" <> '') AND (Rec."8" <> 'X') THEN JoursPointage += 1;
        IF (Rec."9" <> '.') AND (Rec."9" <> '') AND (Rec."9" <> 'X') THEN JoursPointage += 1;
        IF (Rec."10" <> '.') AND (Rec."10" <> '') AND (Rec."10" <> 'X') THEN JoursPointage += 1;
        IF (Rec."11" <> '.') AND (Rec."11" <> '') AND (Rec."11" <> 'X') THEN JoursPointage += 1;
        IF (Rec."12" <> '.') AND (Rec."12" <> '') AND (Rec."12" <> 'X') THEN JoursPointage += 1;
        IF (Rec."13" <> '.') AND (Rec."13" <> '') AND (Rec."13" <> 'X') THEN JoursPointage += 1;
        IF (Rec."14" <> '.') AND (Rec."14" <> '') AND (Rec."14" <> 'X') THEN JoursPointage += 1;
        IF (Rec."15" <> '.') AND (Rec."15" <> '') AND (Rec."15" <> 'X') THEN JoursPointage += 1;
        IF (Rec."16" <> '.') AND (Rec."16" <> '') AND (Rec."16" <> 'X') THEN JoursPointage += 1;
        IF (Rec."17" <> '.') AND (Rec."17" <> '') AND (Rec."17" <> 'X') THEN JoursPointage += 1;
        IF (Rec."18" <> '.') AND (Rec."18" <> '') AND (Rec."18" <> 'X') THEN JoursPointage += 1;
        IF (Rec."19" <> '.') AND (Rec."19" <> '') AND (Rec."19" <> 'X') THEN JoursPointage += 1;
        IF (Rec."20" <> '.') AND (Rec."20" <> '') AND (Rec."20" <> 'X') THEN JoursPointage += 1;
        IF (Rec."21" <> '.') AND (Rec."21" <> '') AND (Rec."21" <> 'X') THEN JoursPointage += 1;
        IF (Rec."22" <> '.') AND (Rec."22" <> '') AND (Rec."22" <> 'X') THEN JoursPointage += 1;
        IF (Rec."23" <> '.') AND (Rec."23" <> '') AND (Rec."23" <> 'X') THEN JoursPointage += 1;
        IF (Rec."24" <> '.') AND (Rec."24" <> '') AND (Rec."24" <> 'X') THEN JoursPointage += 1;
        IF (Rec."25" <> '.') AND (Rec."25" <> '') AND (Rec."25" <> 'X') THEN JoursPointage += 1;
        IF (Rec."26" <> '.') AND (Rec."26" <> '') AND (Rec."26" <> 'X') THEN JoursPointage += 1;
        IF (Rec."27" <> '.') AND (Rec."27" <> '') AND (Rec."27" <> 'X') THEN JoursPointage += 1;
        IF (Rec."28" <> '.') AND (Rec."28" <> '') AND (Rec."28" <> 'X') THEN JoursPointage += 1;
        IF (Rec."29" <> '.') AND (Rec."29" <> '') AND (Rec."29" <> 'X') THEN JoursPointage += 1;
        IF (Rec."30" <> '.') AND (Rec."30" <> '') AND (Rec."30" <> 'X') THEN JoursPointage += 1;
        IF (Rec."31" <> '.') AND (Rec."31" <> '') AND (Rec."31" <> 'X') THEN JoursPointage += 1;


        Rec."Nbre Jours Congé EXP" := "JoursCongéEXP";
        Rec."Nbre Jours Absent" := JoursABS;
        Rec."Nbre Jours Congé" := JoursCongé;
        Rec."Nbre Jours Ferier" := JoursFérié;
        Rec."Nbre Jours Present" := JoursPres;
        Rec."Nbre Total Heures Presnt" := TotalHeurePre;
        IF JoursABS > 0 then Rec."Taux d'absenteisme" := (JoursABS / JoursPointage) * 100 ELSE rEC."Taux d'absenteisme" := 0;
    END;

    trigger OnAfterGetRecord()
    var

    begin

        EDITABLE1 := TRUE;
        EDITABLE2 := TRUE;
        EDITABLE3 := TRUE;
        EDITABLE4 := TRUE;
        EDITABLE5 := TRUE;
        EDITABLE6 := TRUE;
        EDITABLE7 := TRUE;
        EDITABLE8 := TRUE;
        EDITABLE9 := TRUE;
        EDITABLE10 := TRUE;
        EDITABLE11 := TRUE;
        EDITABLE12 := TRUE;
        EDITABLE13 := TRUE;
        EDITABLE14 := TRUE;
        EDITABLE15 := TRUE;
        EDITABLE16 := TRUE;
        EDITABLE17 := TRUE;
        EDITABLE18 := TRUE;
        EDITABLE19 := TRUE;
        EDITABLE20 := TRUE;
        EDITABLE21 := TRUE;
        EDITABLE22 := TRUE;
        EDITABLE23 := TRUE;
        EDITABLE24 := TRUE;
        EDITABLE25 := TRUE;
        EDITABLE26 := TRUE;
        EDITABLE27 := TRUE;
        EDITABLE28 := TRUE;
        EDITABLE29 := TRUE;
        EDITABLE30 := TRUE;
        EDITABLE31 := TRUE;
        RecEntetePointage.RESET;
        RecEntetePointage.SetRange(RecEntetePointage."N°", Rec."N°");
        IF RecEntetePointage.FINDFIRST THEN BEgin
            IF RecEntetePointage."Seuil Jours de Pointage" >= 1 THEN EDITABLE1 := FALSE;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 2 THEN begin

                EDITABLE2 := FALSE;
            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 3 THEN begin

                EDITABLE3 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 4 THEN begin

                EDITABLE4 := FALSE;
                ;
            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 5 THEN begin

                EDITABLE5 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 6 THEN begin

                EDITABLE6 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 7 THEN begin

                EDITABLE7 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 8 THEN begin

                EDITABLE8 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 9 THEN begin

                EDITABLE9 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 10 THEN begin

                EDITABLE10 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 11 THEN begin

                EDITABLE11 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 12 THEN begin

                EDITABLE12 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 13 THEN begin

                EDITABLE13 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 14 THEN begin

                EDITABLE14 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 15 THEN begin

                EDITABLE15 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 16 THEN begin

                EDITABLE16 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 17 THEN begin

                EDITABLE17 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 18 THEN begin

                EDITABLE18 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 19 THEN begin

                EDITABLE19 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 20 THEN begin

                EDITABLE20 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 21 THEN begin

                EDITABLE21 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 22 THEN begin

                EDITABLE22 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 23 THEN begin

                EDITABLE23 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 24 THEN begin

                EDITABLE24 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 25 THEN begin

                EDITABLE25 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 26 THEN begin

                EDITABLE26 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 27 THEN begin

                EDITABLE27 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 28 THEN begin

                EDITABLE28 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 29 THEN begin

                EDITABLE29 := FALSE;

            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 30 THEN begin

                EDITABLE30 := FALSE;
            end;
            IF RecEntetePointage."Seuil Jours de Pointage" >= 31 THEN begin
                EDITABLE31 := FALSE;

            end;

            //*************************** Changer les couleurs ***********************
            case Rec."1" of
                'P':
                    GetStyleForStatus1 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus1 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus1 := 'Ambiguous';
                'X':
                    GetStyleForStatus1 := 'Strong';  // Bleu

                else
                    GetStyleForStatus1 := 'Standard';

            end;

            case Rec."2" of
                'P':
                    GetStyleForStatus2 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus2 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus2 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus2 := 'Strong';
                else
                    GetStyleForStatus2 := 'Standard';

            end;

            case Rec."3" of
                'P':
                    GetStyleForStatus3 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus3 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus3 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus3 := 'Strong';
                else
                    GetStyleForStatus3 := 'Standard';

            end;

            case Rec."4" of
                'P':
                    GetStyleForStatus4 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus4 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus4 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus4 := 'Strong';
                else
                    GetStyleForStatus4 := 'Standard';

            end;
            case Rec."5" of
                'P':
                    GetStyleForStatus5 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus5 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus5 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus5 := 'Strong';
                else
                    GetStyleForStatus5 := 'Standard';

            end;
            case Rec."6" of
                'P':
                    GetStyleForStatus6 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus6 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus6 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus6 := 'Strong';
                else
                    GetStyleForStatus6 := 'Standard';

            end;
            case Rec."7" of
                'P':
                    GetStyleForStatus7 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus7 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus7 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus7 := 'Strong';
                else
                    GetStyleForStatus7 := 'Standard';

            end;
            case Rec."8" of
                'P':
                    GetStyleForStatus8 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus8 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus8 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus8 := 'Strong';
                else
                    GetStyleForStatus8 := 'Standard';

            end;
            case Rec."9" of
                'P':
                    GetStyleForStatus9 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus9 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus9 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus9 := 'Strong';
                else
                    GetStyleForStatus9 := 'Standard';

            end;
            case Rec."10" of
                'P':
                    GetStyleForStatus10 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus10 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus10 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus10 := 'Strong';
                else
                    GetStyleForStatus10 := 'Standard';

            end;
            case Rec."11" of
                'P':
                    GetStyleForStatus11 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus11 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus11 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus11 := 'Strong';
                else
                    GetStyleForStatus11 := 'Standard';

            end;
            case Rec."12" of
                'P':
                    GetStyleForStatus12 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus12 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus12 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus12 := 'Strong';
                else
                    GetStyleForStatus12 := 'Standard';

            end;
            case Rec."13" of
                'P':
                    GetStyleForStatus13 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus13 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus13 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus13 := 'Strong';
                else
                    GetStyleForStatus13 := 'Standard';

            end;
            case Rec."14" of
                'P':
                    GetStyleForStatus14 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus14 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus14 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus14 := 'Strong';
                else
                    GetStyleForStatus14 := 'Standard';

            end;
            case Rec."15" of
                'P':
                    GetStyleForStatus15 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus15 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus15 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus15 := 'Strong';
                else
                    GetStyleForStatus15 := 'Standard';

            end;
            case Rec."16" of
                'P':
                    GetStyleForStatus16 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus16 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus16 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus16 := 'Strong';
                else
                    GetStyleForStatus16 := 'Standard';

            end;
            case Rec."17" of
                'P':
                    GetStyleForStatus17 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus17 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus17 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus17 := 'Strong';
                else
                    GetStyleForStatus17 := 'Standard';

            end;
            case Rec."18" of
                'P':
                    GetStyleForStatus18 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus18 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus18 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus18 := 'Strong';
                else
                    GetStyleForStatus18 := 'Standard';

            end;
            case Rec."19" of
                'P':
                    GetStyleForStatus19 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus19 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus19 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus19 := 'Strong';
                else
                    GetStyleForStatus19 := 'Standard';

            end;
            case Rec."20" of
                'P':
                    GetStyleForStatus20 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus20 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus20 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus20 := 'Strong';
                else
                    GetStyleForStatus20 := 'Standard';

            end;
            case Rec."21" of
                'P':
                    GetStyleForStatus21 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus21 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus21 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus21 := 'Strong';
                else
                    GetStyleForStatus21 := 'Standard';

            end;
            case Rec."22" of
                'P':
                    GetStyleForStatus22 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus22 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus22 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus22 := 'Strong';
                else
                    GetStyleForStatus22 := 'Standard';

            end;
            case Rec."23" of
                'P':
                    GetStyleForStatus23 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus23 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus23 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus23 := 'Strong';
                else
                    GetStyleForStatus23 := 'Standard';

            end;
            case Rec."24" of
                'P':
                    GetStyleForStatus24 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus24 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus24 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus24 := 'Strong';
                else
                    GetStyleForStatus24 := 'Standard';

            end;
            case Rec."25" of
                'P':
                    GetStyleForStatus25 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus25 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus25 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus25 := 'Strong';
                else
                    GetStyleForStatus25 := 'Standard';

            end;
            case Rec."26" of
                'P':
                    GetStyleForStatus26 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus26 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus26 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus26 := 'Strong';
                else
                    GetStyleForStatus26 := 'Standard';

            end;
            case Rec."27" of
                'P':
                    GetStyleForStatus27 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus27 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus27 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus27 := 'Strong';
                else
                    GetStyleForStatus27 := 'Standard';

            end;
            case Rec."28" of
                'P':
                    GetStyleForStatus28 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus28 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus28 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus28 := 'Strong';
                else
                    GetStyleForStatus28 := 'Standard';

            end;
            case Rec."29" of
                'P':
                    GetStyleForStatus29 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus29 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus29 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus29 := 'Strong';
                else
                    GetStyleForStatus29 := 'Standard';

            end;
            case Rec."30" of
                'P':
                    GetStyleForStatus30 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus30 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus30 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus30 := 'Strong';
                else
                    GetStyleForStatus30 := 'Standard';

            end;
            case Rec."31" of
                'P':
                    GetStyleForStatus31 := 'Favorable';   // Vert
                'A':
                    GetStyleForStatus31 := 'Attention';   // Rouge/orange
                'C':
                    GetStyleForStatus31 := 'Ambiguous';   // Bleu
                'X':
                    GetStyleForStatus31 := 'Strong';
                else
                    GetStyleForStatus31 := 'Standard';

            end;

            //*************************** Changer les couleurs ***********************
        end;
    end;

    var
        RecEntetePointage: Record "Entete Pointage Salarier Man";
        EDITABLE1: Boolean;
        EDITABLE2: Boolean;
        EDITABLE3: Boolean;
        EDITABLE4: Boolean;
        EDITABLE5: Boolean;
        EDITABLE6: Boolean;
        EDITABLE7: Boolean;
        EDITABLE8: Boolean;
        EDITABLE9: Boolean;
        EDITABLE10: Boolean;
        EDITABLE11: Boolean;
        EDITABLE12: Boolean;
        EDITABLE13: Boolean;
        EDITABLE14: Boolean;
        EDITABLE15: Boolean;
        EDITABLE16: Boolean;
        EDITABLE17: Boolean;
        EDITABLE18: Boolean;
        EDITABLE19: Boolean;
        EDITABLE20: Boolean;
        EDITABLE21: Boolean;
        EDITABLE22: Boolean;
        EDITABLE23: Boolean;
        EDITABLE24: Boolean;
        EDITABLE25: Boolean;
        EDITABLE26: Boolean;
        EDITABLE27: Boolean;
        EDITABLE28: Boolean;
        EDITABLE29: Boolean;
        EDITABLE30: Boolean;
        EDITABLE31: Boolean;

        GetStyleForStatus1: Text;
        GetStyleForStatus2: Text;
        GetStyleForStatus3: Text;
        GetStyleForStatus4: Text;
        GetStyleForStatus5: Text;
        GetStyleForStatus6: Text;
        GetStyleForStatus7: Text;
        GetStyleForStatus8: Text;
        GetStyleForStatus9: Text;
        GetStyleForStatus10: Text;
        GetStyleForStatus11: Text;
        GetStyleForStatus12: Text;
        GetStyleForStatus13: Text;
        GetStyleForStatus14: Text;
        GetStyleForStatus15: Text;
        GetStyleForStatus16: Text;
        GetStyleForStatus17: Text;
        GetStyleForStatus18: Text;
        GetStyleForStatus19: Text;
        GetStyleForStatus20: Text;
        GetStyleForStatus21: Text;
        GetStyleForStatus22: Text;
        GetStyleForStatus23: Text;
        GetStyleForStatus24: Text;
        GetStyleForStatus25: Text;
        GetStyleForStatus26: Text;
        GetStyleForStatus27: Text;
        GetStyleForStatus28: Text;
        GetStyleForStatus29: Text;
        GetStyleForStatus30: Text;
        GetStyleForStatus31: Text;



}

