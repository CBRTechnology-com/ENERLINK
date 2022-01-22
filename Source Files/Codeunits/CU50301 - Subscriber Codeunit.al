codeunit 50301 MyEventSubscriberCodeunit
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Subst.", 'OnCalcCustPriceOnBeforeCalcQtyAvail', '', true, true)]
    local procedure UpdateDocumentNo(VAR Item: Record Item; SalesLine: Record "Sales Line"; VAR TempItemSubstitution: Record "Item Substitution")
    var
    begin
        TempItemSubstitution.SetSalesOrderNo(SalesLine."Document No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    procedure MyProcedure(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean; VAR DefaultOption: Integer; VAR PostAndSend: Boolean)
    begin
        IF ((SalesHeader."Posting Date" = TODAY) OR (SalesHeader."Document Date" = TODAY)) THEN
            EXIT;
        IF DIALOG.CONFIRM(Confirmation, TRUE) THEN BEGIN
            SalesHeader.Validate("Posting Date", Today);
            SalesHeader.Validate("Document Date", Today);
            SalesHeader.MODIFY;
            DIALOG.MESSAGE(Text001);
        END;

    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    local procedure UpdatePostingDate(VAR PurchaseHeader: Record "Purchase Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean; VAR DefaultOption: Integer)
    begin
        if ((PurchaseHeader."Posting Date" = Today) OR (PurchaseHeader."Document Date" = Today)) then
            exit;
        if Dialog.Confirm(Confirmation, true) then begin
            PurchaseHeader.Validate("Posting Date", today);
            PurchaseHeader.Validate("Document Date", Today);
            PurchaseHeader.Modify();
            Dialog.Message(Text001);
        end;

    end;



    var
        Confirmation: Label 'Do you want to update the Posting Date to Today ?';
        Text001: Label 'Updated Successfully';
}