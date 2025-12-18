import { test, expect } from '@playwright/test';

const new_password = "diego_tester2";
const old_password = "diego_tester";
const username = "diego_tester";

test.describe('Admin flow', () => {
  test.describe.configure({mode: 'serial'});
  //TODO: make this into a FIXTURE
  test("Admin login", async ({page}) => {
    await page.goto("http://localhost:3000/admin/");
    await page.getByLabel("Username:").fill(username);
    await page.getByLabel("Password:").fill(old_password);
    await page.getByRole("button", {name: "Log in"}).click();
    await expect(page.locator(".colMS h1")).toHaveText("Site administration");
  });

  test("Admin password change", async ({page}) => {

    await page.goto("http://localhost:3000/admin/");
    await page.getByLabel("Username:").fill(username);
    await page.getByLabel("Password:").fill(old_password);
    await page.getByRole("button", {name: "Log in"}).click();
    await page.getByRole("link", {name: "Change password"}).click();
    await page.getByLabel("Old password:").fill(old_password);
    await page.getByLabel("New password:").fill(new_password);
    await page.getByLabel("New password confirmation:").fill(new_password);
    await page.getByRole("button", {name: "Change my password"}).click();
    await page.getByRole("button", {name: "Log out"}).click();
    await page.waitForURL('http://localhost:3000/');
    await page.goto("http://localhost:3000/admin/");
    await page.getByLabel("Username:").fill(username);
    await page.getByLabel("Password:").fill(new_password);
    await page.getByRole("button", {name: "Log in"}).click();
    await expect(page.locator(".colMS h1")).toHaveText("Site administration");
    // clean up, restore old password
    await page.getByRole("link", {name: "Change password"}).click();
    await page.getByLabel("Old password:").fill(new_password);
    await page.getByLabel("New password:").fill(old_password);
    await page.getByLabel("New password confirmation:").fill(old_password);
    await page.getByRole("button", {name: "Change my password"}).click();
  });
});

