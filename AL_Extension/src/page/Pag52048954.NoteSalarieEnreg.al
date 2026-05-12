page 52048954 "Note Salariée Enreg."
{//GL2024  ID dans Nav 2009 : "39001475"
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Ligne Pointage Salarié Chanti";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Note Salariée Enreg.';
    layout
    {
        area(content)
        {

            repeater(Control1102752009)
            {
                ShowCaption = false;
                field(Matricule; Rec.Matricule)
                {
                    ApplicationArea = Basic;
                }
                field(Nom; Rec.Nom)
                {
                    ApplicationArea = Basic;
                }
                field("D.Hr sup"; Rec."D.Hr sup")
                {
                    ApplicationArea = Basic;
                }
                field("Nom 1"; Rec."Nom 1")
                {
                    ApplicationArea = Basic;
                }
                field(NomPrenom; NomPrenom)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employée';
                    Editable = false;
                }
                field(Panier; Rec.Panier)
                {
                    ApplicationArea = Basic;
                }
                field(Bage; Rec.Bage)
                {
                    ApplicationArea = Basic;
                }
            }

        }
    }

    actions
    {
        area(Promoted)
        {
            group(Fonction1)
            {
                Caption = 'Fonction';
                actionref("Devalider Notes1"; "Devalider Notes")
                {

                }
            }
        }
        area(navigation)
        {
            group(Fonction)
            {
                Caption = 'Fonction';
                action("Devalider Notes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Devalider Notes';

                    trigger OnAction()
                    var
                        Noteeng: Record "Ligne Pointage Salarié Chanti";
                        Note: Record "Ligne Pointage Salarié Chanti";
                        Empl: Record Employee;
                    begin

                        Empl.RESET;
                        CurrPage.SETSELECTIONFILTER(Empl);
                        j := 0;
                        Note.RESET;
                        IF Note.FIND('+') THEN
                            //j := FORMAT(Note.Code);
                            IF Empl.FIND('-') THEN
                                REPEAT
                                    Noteeng.RESET;
                                    Noteeng.SETRANGE(Matricule, format(year));
                                    IF TrimestreT = 0 THEN
                                        Noteeng.SETFILTER(Nom, '>0')
                                    ELSE
                                        Noteeng.SETRANGE(Nom, format(TrimestreT));
                                    Noteeng.SETFILTER("Nom 1", Empl."No.");
                                    IF Noteeng.FIND('-') THEN BEGIN
                                        REPEAT
                                            j := j + 1;
                                            Note.INIT;
                                            Note.TRANSFERFIELDS(Noteeng);
                                            //Note.Code:=j;
                                            IF Note.INSERT THEN
                                                Noteeng.DELETE;
                                        UNTIL Noteeng.NEXT = 0;
                                    END;


                                UNTIL Empl.NEXT = 0;

                    end;
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        if RecSla.Get(Rec."Nom 1") then
            NomPrenom := RecSla."First Name" + ' ' + RecSla."Last Name";
        Message(Rec."Nom 1");
    end;

    var
        TrimestreT: Option "1ère","2ème","3ème","4ème",Annuel;
        year: Integer;
        Val: array[5] of Decimal;
        i: Integer;
        Tot: Decimal;
        ValT: array[5] of Decimal;
        LigneNoteeng: Record "Ligne Pointage Salarié Chanti";
        LigneNoteTmp: Record "Ligne Pointage Salarié Chanti";
        Nline: Integer;
        NbTrim: Integer;
        Mnt: Decimal;
        "Filtre Catégorie": Option " ","Hors Grille",Grille;
        j: Integer;
        RecSla: Record Employee;
        NomPrenom: Text[30];


    procedure actfields()
    begin
        /*IF TrimestreT>0 THEN BEGIN
             Currpage.Val1.VISIBLE:=TRUE;
             Currpage.Val2.VISIBLE:=TRUE;
             Currpage.Val3.VISIBLE:=TRUE;
             Currpage.Val4.VISIBLE:=TRUE;
             Currpage.MntP.VISIBLE:=TRUE;
             Currpage.Val21.VISIBLE:=FALSE;
             Currpage.Val22.VISIBLE:=FALSE;
             Currpage.Val23.VISIBLE:=FALSE;
             Currpage.Val24.VISIBLE:=FALSE;
             Currpage.Polyvalence.VISIBLE:=TRUE;
          END ELSE BEGIN
             Currpage.Val21.VISIBLE:=TRUE;
             Currpage.Val22.VISIBLE:=TRUE;
             Currpage.Val23.VISIBLE:=TRUE;
             Currpage.Val24.VISIBLE:=TRUE;
             Currpage.Polyvalence.VISIBLE:=FALSE;
                Currpage.MntP.VISIBLE:=FALSE;
             Currpage.Val1.VISIBLE:=FALSE;
             Currpage.Val2.VISIBLE:=FALSE;
             Currpage.Val3.VISIBLE:=FALSE;
             Currpage.Val4.VISIBLE:=FALSE;
           END;
         */

    end;
}

