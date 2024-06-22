// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { console2 } from "forge-std/console2.sol";
import { SafeUnitBase } from "../../SafeUnitBase.t.sol";

contract SafeRecoverySubjectHandler_getPreviousOwnerInLinkedList_Test is SafeUnitBase {
    address internal constant SENTINEL_OWNERS = address(0x1);

    function setUp() public override {
        super.setUp();
    }

    function test_GetPreviousOwnerInLinkedList_InvalidOwner_ReturnsSentinel() public view {
        address invalidOwner = address(0);

        address previousOwner = safeRecoverySubjectHandler.exposed_getPreviousOwnerInLinkedList(
            accountAddress1, invalidOwner
        );

        assertEq(previousOwner, SENTINEL_OWNERS);
    }

    function test_GetPreviousOwnerInLinkedList_OwnerIsSentinel_ReturnsSentinel() public view {
        address invalidOwner = SENTINEL_OWNERS;

        address previousOwner = safeRecoverySubjectHandler.exposed_getPreviousOwnerInLinkedList(
            accountAddress1, invalidOwner
        );

        assertEq(previousOwner, SENTINEL_OWNERS);
    }

    function test_GetPreviousOwnerInLinkedList_RevertWhen_InvalidAccount() public {
        address invalidAccount = address(0);

        vm.expectRevert();
        safeRecoverySubjectHandler.exposed_getPreviousOwnerInLinkedList(invalidAccount, owner1);
    }

    function test_GetPreviousOwnerInLinkedList_Succeeds() public view {
        address expectedPreviousOwner = address(1);
        address previousOwner =
            safeRecoverySubjectHandler.exposed_getPreviousOwnerInLinkedList(accountAddress1, owner1);

        assertEq(expectedPreviousOwner, previousOwner);
    }

    function test_GetPreviousOwnerInLinkedList_SucceedsWithMultipleAccounts() public {
        address expectedPreviousOwner = address(1);
        address previousOwner =
            safeRecoverySubjectHandler.exposed_getPreviousOwnerInLinkedList(accountAddress, owner);

        assertEq(expectedPreviousOwner, previousOwner);
        previousOwner =
            safeRecoverySubjectHandler.exposed_getPreviousOwnerInLinkedList(accountAddress, anotherOwner);
        assertEq(expectedPreviousOwner, previousOwner);
    }
}
