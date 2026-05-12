PageExtension 50252 "Config. Template Header_PagEXT" extends "Config. Template Header"
{
    layout
    {
        addafter("Table Name")
        {
            field("Validation Template"; Rec."Validation Template")
            {
                ApplicationArea = all;
            }
            field(Synchronisation; Rec.Synchronisation)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

        addafter(CreateInstance)
        {
            action("&Proposer")
            {
                ApplicationArea = all;
                Caption = '&Proposer';

                trigger OnAction()
                var
                    TemplateMgt: Codeunit "Config. Template Management";
                    CduFunction: Codeunit SoroubatFucntion;
                begin
                    CduFunction.Suggest(Rec);
                end;
            }
            action("Sélectionner")
            {
                ApplicationArea = all;
                Caption = 'Select';

                trigger OnAction()
                var
                    TemplateMgt: Codeunit "Config. Template Management";
                    CduFunction: Codeunit SoroubatFucntion;
                begin
                    CduFunction.Select(Rec);
                end;
            }

            /*GL2024 action("Contrôler")
             {
                 ApplicationArea = all;
                 Caption = 'Check';
                 //DYS REPORT addon non migrer
                 // RunObject = Report 8001413;


             }*/
            action("Synchro")
            {
                ApplicationArea = all;
                Caption = 'Synchro';
                trigger OnAction()
                begin
                    SynchroniserPush(27)
                end;


            }
        }
        addafter(Category_New)
        {
            actionref("&Proposer1"; "&Proposer")
            {

            }
            actionref("Sélectionner1"; "Sélectionner")
            {

            }
            actionref("Synchro1"; "Synchro")
            {

            }
        }
    }
    VAR
        Text000: Label 'New instance %1 has been created in table %2 %3';

    PROCEDURE ConfirmNewInstance(VAR RecRef: RecordRef);
    VAR
        KeyRef: KeyRef;
        FieldRef: FieldRef;
        KeyFieldCount: Integer;
        MessageString: Text[1024];
    BEGIN
        KeyRef := RecRef.KEYINDEX(1);
        FOR KeyFieldCount := 1 TO KeyRef.FIELDCOUNT DO BEGIN
            FieldRef := KeyRef.FIELDINDEX(KeyFieldCount);
            MessageString := MessageString + ' ' + FORMAT(FieldRef.VALUE);
            MessageString := DELCHR(MessageString, '<');
            MESSAGE(STRSUBSTNO(Text000, MessageString, RecRef.NUMBER, RecRef.CAPTION));
        END;
    END;

    PROCEDURE SynchroniserPush(IdTable: Integer);
    VAR
        RecordRef: RecordRef;
        //RecordRefSynchro: Record "Code Opération Caisse";
        Compteur: Integer;
        Ref: RecordRef;
    BEGIN
        /*  RecordRef.OPEN(IdTable);
          RecordRefSynchro.INIT;
          IF RecordRef.FINDFIRST THEN
              REPEAT
                  Compteur += 1;
                  IF Compteur = 1 THEN MESSAGE(FORMAT(RecordRef.FIELDINDEX(1).VALUE));
                  //RecordRefSynchro.VALIDATE:=RecordRef.FIELDINDEX(1).VALUE;
                  //Ref.FIELD(1).SEtVALUE:=1;
                  RecordRefSynchro.INSERT;
              UNTIL RecordRef.NEXT = 0;*/
    END;
}
