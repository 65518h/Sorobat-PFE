Codeunit 8004003 SearchCode
{
    // //RECHERCHE GESWAY 27/06/03


    trigger OnRun()
    var
        lArt: Record Item;
        lRecDef: RecordRef;
        lCode: Code[20];
    begin
        lRecDef.GetTable(lArt);
        lCode := 'pose';
        Search(lRecDef, lCode);
    end;

    var
        tSearching: label 'Search ...';
        tTableIDerror: label 'Reserch not define for table %1';


    procedure Search(var pRecRef: RecordRef; var pNo: Code[20])
    var
        lFilter: Text[80];
        lFieldRefNum: FieldRef;
        lFieldRefDescr: FieldRef;
        Fenetre: Dialog;
        lItem: Record Item;
        //GL2024 NAVIBAT      lForm: Page 8003927;
        lRes: Record Resource;
    begin
        //lFieldRefNum := pRecRef.FIELD(1);
        case pRecRef.Number of
            Database::Item:
                begin
                    lFieldRefNum := pRecRef.Field(1);
                    lFieldRefDescr := pRecRef.Field(4);
                    //    pRecRef.SETVIEW('SORTING(Search Description)');
                end;
            Database::Resource:
                begin
                    lFieldRefNum := pRecRef.Field(1);
                    lFieldRefDescr := pRecRef.Field(4);
                    //    pRecRef.SETVIEW('SORTING(Search Name)');
                end;
            else
                Error(tTableIDerror, pRecRef.Number);
        end;

        //lFieldRefNum.SETFILTER(pNo);
        //ML lFieldRefNum.SETRANGE(pNo);
        lFieldRefNum.SetFilter('%1', pNo + '*');
        pRecRef := lFieldRefNum.Record;       //ML

        if not pRecRef.FindFirst then begin
            lFieldRefNum.SetRange;
            pRecRef := lFieldRefNum.Record;
            lFilter := pNo;
            Fenetre.Open(tSearching);
            case pRecRef.Number of
                Database::Item:
                    pRecRef.CurrentKeyIndex(2);
                Database::Resource:
                    pRecRef.CurrentKeyIndex(2);
            end;

            lFieldRefDescr.SetFilter(lFilter);

            pRecRef := lFieldRefDescr.Record;

            if pRecRef.IsEmpty and (lFilter <> '') then begin
                lFilter := '@' + lFilter + '*';
                lFieldRefDescr.SetFilter(lFilter)
            end;

            //  IF (pRecRef.COUNT = 0) AND (lFilter <> '') THEN
            if (pRecRef.IsEmpty) and (lFilter <> '') then
                lFieldRefDescr.SetFilter('*' + lFilter);
            Fenetre.Close;

            pRecRef := lFieldRefDescr.Record;
            if pRecRef.IsEmpty then begin
                pNo := '';
                exit;
            end else
                pNo := OpenForm(pRecRef, lFilter);
        end else
            pNo := OpenForm(pRecRef, lFilter);
    end;


    procedure OpenItemForm(var pRecRef: RecordRef) rNo: Code[20]
    var
        lItem: Record Item;
    begin
        lItem.SetView(pRecRef.GetView);
        lItem.SetCurrentkey("Search Description");

        if Page.RunModal(0, lItem) = Action::LookupOK then
            rNo := lItem."No."
        else
            rNo := '';
    end;


    procedure OpenResForm(var pRecRef: RecordRef) rNo: Code[20]
    var
        lRes: Record Resource;
    begin
        lRes.SetView(pRecRef.GetView);
        lRes.SetCurrentkey(Type, "No.");
        if Page.RunModal(0, lRes) = Action::LookupOK then
            rNo := lRes."No."
        else
            rNo := '';
    end;


    procedure OpenSearchForm(var pRecRef: RecordRef; pFilter: Text[80]) rNo: Code[20]
    var
        lFieldRefNum: FieldRef;
        lFieldRefDescr: FieldRef;
    //GL2024 NAVIBAT  lForm: Page 8003927;
    begin
        lFieldRefDescr.SetFilter(pFilter + '*');
        pRecRef := lFieldRefDescr.Record;
        //GL2024 NAVIBAT   lForm.LookupMode(true);
        //GL2024 NAVIBAT    lForm.PasseRecord(pRecRef);
        //GL2024 NAVIBAT   if lForm.RunModal = Action::LookupOK then
        //GL2024 NAVIBAT       lForm.PasseNum(rNo)
        //GL2024 NAVIBAT  else
        rNo := '';
    end;


    procedure OpenForm(var pRecRef: RecordRef; pFilter: Text[80]) rNo: Code[20]
    var
        lFieldRefNum: FieldRef;
        lFieldRefDescr: FieldRef;
    //GL2024 NAVIBAT   lForm: Page 8003927;
    begin
        if pRecRef.Count = 1 then begin
            pRecRef.FindFirst;
            Evaluate(rNo, Format(pRecRef.Field(1)));
        end else begin
            pRecRef.Find('-');
            case pRecRef.Number of
                Database::Item:
                    begin
                        rNo := OpenItemForm(pRecRef);
                    end;
                Database::Resource:
                    begin
                        rNo := OpenResForm(pRecRef);
                    end;
                else begin
                    rNo := OpenSearchForm(pRecRef, pFilter);
                end;
            end;
        end;
    end;
}

