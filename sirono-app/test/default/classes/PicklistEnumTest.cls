/*
 * Copyright 2017-present Sirono LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@IsTest
private class PicklistEnumTest extends PicklistEnum {

    // Test generic functionality for the base class
    @IsTest
    private static void testPicklistEnum() {
        List<Schema.PicklistEntry> picklistEntries = Asset.Status.getDescribe().getPicklistValues();
        for (PicklistEntry picklistEntry : picklistEntries) {
            String value = picklistEntry.getValue();
            PicklistEnum.Entry entry = PicklistEnumTest.valueOf(value);
            Assert.isNotNull(entry, 'Expected to find a picklist enum entry for ' + value);
            Assert.equals(value, entry.value(), 'Incorrect value for entry.');

            String label = picklistEntry.getLabel();
            Assert.equals(label, entry.label(), 'Incorrect label for entry.');

            Boolean active = picklistEntry.isActive();
            Assert.equals(active, entry.isActive(), 'Incorrect active state for entry.');

            Boolean defaultValue = picklistEntry.isDefaultValue();
            Assert.equals(defaultValue, entry.isDefaultValue(), 'Incorrect default value state for entry.');
        }
    }

    // Test a sample implementation of the base class
    @IsTest
    private static void testAssetStatusEnum() {
        PicklistEnumTestUtil.verifyPicklistEnum(
            Asset.Status,
            new Map<String, PicklistEnum.Entry> {
                PicklistEnumTest.ASSET_PURCHASED_VALUE => PicklistEnumTest.ASSET_PURCHASED,
                PicklistEnumTest.ASSET_SHIPPED_VALUE => PicklistEnumTest.ASSET_SHIPPED,
                PicklistEnumTest.ASSET_INSTALLED_VALUE => PicklistEnumTest.ASSET_INSTALLED,
                PicklistEnumTest.ASSET_REGISTERED_VALUE => PicklistEnumTest.ASSET_REGISTERED,
                PicklistEnumTest.ASSET_OBSOLETE_VALUE => PicklistEnumTest.ASSET_OBSOLETE
            },
            PicklistEnumTest.values()
        );
    }

    @IsTest
    static void testEqualTo() {
        Assert.isTrue(PicklistEnumTest.ASSET_PURCHASED.equalTo(ASSET_PURCHASED_VALUE));
        Assert.isTrue(PicklistEnumTest.ASSET_PURCHASED.equalTo(ASSET_PURCHASED_VALUE.toLowerCase()));
        Assert.isTrue(PicklistEnumTest.ASSET_PURCHASED.equalTo(ASSET_PURCHASED_VALUE.toUpperCase()));
        Assert.isFalse(PicklistEnumTest.ASSET_PURCHASED.equalTo(ASSET_SHIPPED_VALUE));
    }

    @IsTest
    static void testNotEqualTo() {
        Assert.isTrue(PicklistEnumTest.ASSET_PURCHASED.notEqualTo(ASSET_SHIPPED_VALUE));
        Assert.isFalse(PicklistEnumTest.ASSET_PURCHASED.notEqualTo(ASSET_PURCHASED_VALUE));
        Assert.isFalse(PicklistEnumTest.ASSET_PURCHASED.notEqualTo(ASSET_PURCHASED_VALUE.toLowerCase()));
        Assert.isFalse(PicklistEnumTest.ASSET_PURCHASED.notEqualTo(ASSET_PURCHASED_VALUE.toUpperCase()));
    }

    @IsTest
    static void testToString() {
        Assert.equals(ASSET_PURCHASED_VALUE, PicklistEnumTest.ASSET_PURCHASED.toString());
        Assert.equals(ASSET_SHIPPED_VALUE, PicklistEnumTest.ASSET_SHIPPED.toString());
        Assert.equals(ASSET_INSTALLED_VALUE, PicklistEnumTest.ASSET_INSTALLED.toString());
        Assert.equals(ASSET_REGISTERED_VALUE, PicklistEnumTest.ASSET_REGISTERED.toString());
        Assert.equals(ASSET_OBSOLETE_VALUE, PicklistEnumTest.ASSET_OBSOLETE.toString());
    }

    // Sample implementation of PicklistEnum for testing purposes.
    // NOTE: Cannot be an inner class because inner classes can't be static.

    private static final PicklistEnumTest INSTANCE = new PicklistEnumTest();

    private static final String ASSET_PURCHASED_VALUE = 'Purchased';
    private static final String ASSET_SHIPPED_VALUE = 'Shipped';
    private static final String ASSET_INSTALLED_VALUE = 'Installed';
    private static final String ASSET_REGISTERED_VALUE = 'Registered';
    private static final String ASSET_OBSOLETE_VALUE = 'Obsolete';

    // TODO: Unfortunately no picklist entry is flagged as default so that logic isn't tested
    private static final Entry ASSET_PURCHASED = valueOf(ASSET_PURCHASED_VALUE);
    private static final Entry ASSET_SHIPPED = valueOf(ASSET_SHIPPED_VALUE);
    private static final Entry ASSET_INSTALLED = valueOf(ASSET_INSTALLED_VALUE);
    private static final Entry ASSET_REGISTERED = valueOf(ASSET_REGISTERED_VALUE);
    private static final Entry ASSET_OBSOLETE = valueOf(ASSET_OBSOLETE_VALUE);

    private PicklistEnumTest() {
        super(Asset.Status);
    }

    public static Entry valueOf(String value) {
        return INSTANCE.getEntry(value);
    }

    public static Entry[] values() {
        return INSTANCE.getEntries();
    }
}