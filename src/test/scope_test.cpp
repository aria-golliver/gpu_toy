#include "scope.h"
#include "gtest/gtest.h"


TEST(Scope, ScopeOnlyFiresOnceWhenOutOfScope) {
    int timesFired = 0;
    {
        auto scope = Scope([&]{++timesFired;});
        ASSERT_EQ(timesFired, 0);
    }
    ASSERT_EQ(timesFired, 1);
}

TEST(Scope, CanCorrectlyOperatorMoveOutOfScope) {
    int timesFiredA = 0;
    int timesFiredB = 0;
	{
		Scope scopeA = Scope([&] {++timesFiredA; });
		{
			Scope scopeB = Scope([&] {++timesFiredB; });
			scopeA = std::move(scopeB);
			ASSERT_EQ(timesFiredA, 1);
			ASSERT_EQ(timesFiredB, 0);
		}
	}
	ASSERT_EQ(timesFiredA, 1);
    ASSERT_EQ(timesFiredB, 1);
}

TEST(Scope, CanCorrectlyCtorMoveOutOfScope) {
    int timesFiredA = 0;
    Scope scopeA = Scope([&]{++timesFiredA;});
    {
        Scope scopeB(std::move(scopeA));
        ASSERT_EQ(timesFiredA, 0);
    }
    ASSERT_EQ(timesFiredA, 1);
}

TEST(Scope, NullPtrDoesntBreak) {
    auto scope = Scope(nullptr);
}

TEST(Scope, CanCorrectlyOperatorCopyScopes) {
	int timesFiredA = 0;
	int timesFiredB = 0;
	{
		Scope scopeA = Scope([&] {++timesFiredA; });
		{
			Scope scopeB = Scope([&] {++timesFiredB; });
			scopeB = scopeA;
			ASSERT_EQ(timesFiredA, 0);
			ASSERT_EQ(timesFiredB, 1);
		}
		ASSERT_EQ(timesFiredA, 1);
		ASSERT_EQ(timesFiredB, 1);
	}
	ASSERT_EQ(timesFiredA, 2);
	ASSERT_EQ(timesFiredB, 1);
}

TEST(Scope, CanCorrectlyCtorCopyScopes) {
	int timesFiredA = 0;
	{
		Scope scopeA = Scope([&] {++timesFiredA; });
		{
			Scope scopeB = scopeA;
			ASSERT_EQ(timesFiredA, 0);
		}
		ASSERT_EQ(timesFiredA, 1);
	}
	ASSERT_EQ(timesFiredA, 2);
}